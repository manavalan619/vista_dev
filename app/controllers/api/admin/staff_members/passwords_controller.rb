module Api
  module Admin
    module StaffMembers
      class PasswordsController < Api::Admin::ApiController
        skip_before_action :authenticate
        before_action :skip_authorization
        before_action :find_staff_member

        def create
          if @staff_member && @staff_member.send_reset_password_instructions
            render json: { success: 'Password reset email sent' }, status: 202
          else
            render json: {
              errors: [{
                title: 'No user found for request',
                source: {
                  parameter: 'email'
                }
              }]
            }, status: 400
          end
        end

        def update
          if @staff_member
            password = staff_member_params[:password]
            password_confirmation = staff_member_params[:password_confirmation]
            if @staff_member.reset_password(password, password_confirmation)
              render json: { success: 'Password successfully reset' }, status: 202
            else
              render json: { errors: @staff_member.errors.messages }, status: 400
            end
          else
            # NB: no user found which means token is invalid
            render json: {
              errors: [{
                title: 'Password reset token invalid',
                source: {
                  parameter: 'token'
                }
              }]
            }, status: 400
          end
        end

        private

        def find_staff_member
          if params[:email]
            @staff_member = User.find_by(email: params[:email])
          else
            @staff_member = User.find_by(
              reset_password_token: Devise.token_generator.digest(
                self, :reset_password_token, staff_member_params[:token]
              )
            )
          end
        end

        def staff_member_params
          params.require(:password_reset).permit(
            :email, :password, :password_confirmation, :token
          )
        end
      end
    end
  end
end
