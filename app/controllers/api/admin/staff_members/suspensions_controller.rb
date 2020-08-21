module Api
  module Admin
    module StaffMembers
      class SuspensionsController < Api::Admin::ApiController
        before_action :find_staff_member

        def suspend
          authorize @staff_member, :suspend?
          puts 'hello'
          if StaffMember::Suspend.call(@staff_member).success?
            render json: @staff_member, status: 201
          else
            render json: @staff_member, status: 422
          end
        end

        def unsuspend
          authorize @staff_member, :unsuspend?
          if StaffMember::Unsuspend.call(@staff_member).success?
            render json: @staff_member, status: 201
          else
            render json: @staff_member, status: 422
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
