module Api
  module Admin
    module StaffMembers
      class ConfirmationsController < Api::Admin::ApiController
        skip_before_action :authenticate
        before_action :skip_authorization

        def update
          with_unconfirmed_confirmable do
            if @confirmable.no_password?
              @confirmable.attempt_set_password(params[:staff_member])
              if @confirmable.valid? and @confirmable.password_match?
                do_confirm
              else
                render_errors(@confirmable.errors)
              end
            else
              render_errors([{ title: 'Account already confirmed' }])
            end
          end

          unless @confirmable.errors.empty?
            render_errors(@confirmable.errors)
          end
        end

        private

        def with_unconfirmed_confirmable
          @confirmable = StaffMember.find_or_initialize_with_error_by(
            :confirmation_token, staff_member_params[:token]
          )

          @confirmable.only_if_unconfirmed { yield } unless @confirmable.new_record?
        end

        def render_errors(errors = [{ title: 'Could not confirm account' }])
          render json: { errors: errors }, status: 400
        end

        def do_confirm
          @confirmable.confirm
          render json: { success: 'Account confirmed' }, status: 202
        end

        def staff_member_params
          params.require(:staff_member).permit(:password, :password_confirmation, :token)
        end
      end
    end
  end
end
