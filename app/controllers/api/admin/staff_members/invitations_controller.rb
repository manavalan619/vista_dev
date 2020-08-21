module Api
  module Admin
    module StaffMembers
      class InvitationsController < Api::Admin::ApiController
        before_action :find_staff_member

        def update
          authorize @staff_member, :invite?
          if @staff_member.confirmed?
            render json: { errors: [{ title: 'Already confirmed' }] }, status: 400
          else
            @staff_member.resend_confirmation_instructions
            render json: { success: 'User invite was successfully resent.' }, status: 201
          end
        end

        private

        def find_staff_member
          @staff_member = StaffMember.find params[:staff_id]
        end
      end
    end
  end
end
