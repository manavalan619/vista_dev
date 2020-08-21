module Api
  module Partners
    module V1
      module Management
        class AuthenticationController < Api::Partners::V1::BaseController
          skip_before_action :authenticate, only: :create
          skip_before_action :find_branch, only: :create

          # TODO: make sure devise login tracking methods are called
          def create
            @command = StaffMember::Management::Authenticate.call(params[:email], params[:password])
            if @command.success?
              user = @command.result
              sign_in user, store: false # Devise login
              token = AuthenticationToken.create_and_return_manager_token(user, request)
              render json: {
                token: token,
                analyticsToken: AuthenticationToken.create_and_return_analytics_token
              }
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
