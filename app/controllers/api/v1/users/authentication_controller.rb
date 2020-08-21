module Api
  module V1
    module Users
      class AuthenticationController < Api::V1::BaseController
        skip_before_action :authenticate, only: :create

        def create
          @command = User::Authenticate.call(params[:email], params[:password])
          if @command.success?
            user = @command.result
            if user.archived_at.nil?
              sign_in user, store: false # Devise login
              render json: {
                memberId: user.id,
                analyticsToken: AuthenticationToken.create_and_return_analytics_token,
                token: user.authentication_token,
                needsOnboarding: !user.onboarding_complete
              }
            else
              render_error
            end
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
