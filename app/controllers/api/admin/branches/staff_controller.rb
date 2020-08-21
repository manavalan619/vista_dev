module Api
  module Admin
    module Branches
      class StaffController < Api::Admin::ApiController
        before_action :find_unit
        before_action :find_branch

        def index
          skip_authorization
          @staff_members = @branch.staff_members
          render json: @staff_members if stale?(@staff_members)
        end

        def create
          skip_authorization
          command = StaffAssignment::Create.call(@staff_member, @branch)
          if command.success?
            head :ok
          else
            head 422
          end
        end

        def destroy
          skip_authorization
          command = StaffAssignment::Destroy.call(@staff_member, @branch)

          if command.success?
            head :ok
          else
            head 422
          end
        end

        private

        def find_partner
          @staff_member = current_organisation.staff_members.find params[:user_id]
        end

        def find_unit
          @business_unit = policy_scope(BusinessUnit).find(params[:unit_id])
        end

        def find_branch
          @branch = @business_unit.branches.find(params[:branch_id])
        end
      end
    end
  end
end
