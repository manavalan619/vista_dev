module Api
  module V1
    module Users
      class RegistrationController < Api::V1::BaseController
        skip_before_action :authenticate, only: :create

        def create
          @command = User::Register.call(user_params)
          if @command.success?
            render json: {
              token: @command.result,
              needsOnboarding: true
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
