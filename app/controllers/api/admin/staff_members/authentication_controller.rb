module Api
  module Admin
    module StaffMembers
      class AuthenticationController < Api::Admin::ApiController
        skip_before_action :authenticate, only: :create
        skip_after_action :verify_authorized

        def create
          command = StaffMember::Authenticate.call(params[:email], params[:password])
          if command.success?
            staff_member = command.result
            if staff_member.suspended_at.nil?
              render json: {
                token: staff_member.authentication_token,
                organisation: staff_member.organisation.name,
                user_type: staff_member.type
              }
            else
              render json: { errors: command.errors }, status: :unauthorized
            end
          else
            render json: { errors: command.errors }, status: :unauthorized
          end
        end
      end
    end
  end
end
