module Api
  module Partners
    module V1
      module Staff
        class AuthenticationController < Api::Partners::V1::BaseController
          skip_before_action :authenticate, only: :create
          before_action :authenticate_manager

          # TODO: make sure devise login tracking methods are called
          def create
            @command = StaffMember::Staff::Authenticate.call(
              organisation: current_organisation,
              employee_id: params[:employee_id],
              pin: params[:pin]
            )
            if @command.success?
              user = @command.result
              sign_in user, store: false # Devise login
              token = AuthenticationToken.create_and_return_staff_token(user, request)
              render json: { token: token }
            else
              render_error
            end
          end

          private

          def render_error
            render json: @command,
                  status: 401,
                  adapter: :json_api,
                  serializer: ActiveModel::Serializer::ErrorSerializer
          end

          def user_params
            params.permit(:email, :password)
          end
        end
      end
    end
  end
end
