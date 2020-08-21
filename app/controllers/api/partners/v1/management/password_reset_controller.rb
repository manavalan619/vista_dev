module Api::Partners::V1::Management
  class PasswordResetController < Api::Partners::V1::BaseController
    skip_before_action :authenticate, :find_branch

    def create
      @user = StaffMember.management.find_by(email: params[:email])

      if @user&.send_reset_password_instructions
        render json: { success: 'Password reset email sent' }, status: 202
      else
        render json: { errors: [{ detail: 'No user found for request' }] }, status: 400
      end
    end

    def update
      @user = StaffMember.management.reset_password_by_token(reset_params)

      if @user.errors.empty?
        @user.unlock_access! if unlockable?
        render json: { success: 'Password successfully reset' }, status: 202
      else
        render json: { errors: @user.errors }, status: 400
      end
    end

    private

    def user_params
      params.permit(:email, :password, :password_confirmation, :token)
    end

    def reset_params
      user_params.merge(reset_password_token: user_params[:token])
    end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    def unlockable?
      @user.respond_to?(:unlock_access!) &&
        @user.respond_to?(:unlock_strategy_enabled?) &&
        @user.unlock_strategy_enabled?(:email)
    end
  end
end
