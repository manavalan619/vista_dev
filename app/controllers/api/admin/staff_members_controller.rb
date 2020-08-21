module Api::Admin
  class StaffMembersController < Api::Admin::ApiController
    before_action :find_staff_member, except: %i(index create)

    def index
      @staff_members = policy_scope(StaffMember)
      authorize @staff_members
      render json: @staff_members
    end

    def show
      authorize @staff_member
      render json: @staff_member if stale?(@staff_member)
    end

    def create
      params[:staff_member][:branch_id] = params[:staff_member].delete(:branch)
      params[:staff_member][:branch_id] = params[:staff_member][:branch_id] || current_user.branch.id
      @staff_member = current_organisation.staff_members.new
      authorize @staff_member
      if StaffMember::Create.call(@staff_member, allowed_params).success?
        render json: @staff_member, status: 201
      else
        render json: @staff_member, status: 422
      end
    end

    def update
      params[:staff_member][:branch_id] = params[:staff_member].delete(:branch)
      params[:staff_member][:branch_id] =  params[:staff_member][:branch_id] || current_user.branch.id
      authorize @staff_member
      if StaffMember::Update.call(@staff_member, allowed_params).success?
        render json: @staff_member, status: 200
      else
        render json: @staff_member, status: 422
      end
    end

    def destroy
      authorize @staff_member
      if StaffMember::Destroy.call(@staff_member).success?
        head :no_content
      else
        head 422
      end
    end

    private

    def staff_member_params
      params.require(:staff_member).permit(
        :employee_id, :first_name, :last_name, :mobile_number, :email,
        :type, :branch_id, :pin, :status, role_ids: [], photos_attributes: %i[image]
      )
    end

    def allowed_params
      case current_user
      when Admin
        staff_member_params
      when BranchManager
        staff_member_params.except(:type, :status)
      end
    end

    def find_staff_member
      @staff_member = StaffMember.find(params[:id])
    end
  end
end
