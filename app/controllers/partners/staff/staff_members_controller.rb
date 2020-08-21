class Partners::Staff::StaffMembersController < Partners::BaseController
  before_action :set_staff_member, only: %i[show edit update destroy]

  def index
    @staff_members = policy_scope(StaffMember).only_staff_members
    authorize @staff_members
  end

  def show
    redirect_to [:edit, :partners, @staff_member]
  end

  def new
    @staff_member = current_organisation.staff_members.new
    authorize @staff_member
  end

  def edit
    authorize @staff_member
  end

  def create
    @staff_member = current_organisation.staff_members.new(staff_member_params)
    @staff_member.confirmed_at = Time.current
    authorize @staff_member

    if @staff_member.save
      redirect_to %i[partners staff_members], success: 'Staff member was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @staff_member

    if @staff_member.update(staff_member_params)
      redirect_to %i[partners staff_members], success: 'Staff member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @staff_member
    @staff_member.destroy
    redirect_to %i[partners staff_members], success: 'Staff member was successfully removed.'
  end

  private

  def set_staff_member
    @staff_member = current_organisation.staff_members.find(params[:id])
  end

  def staff_member_params
    params.require(:staff_member).permit(
      :first_name, :last_name, :mobile_number, :employee_id,
      :pin, :pin_confirmation, assigned_branch_ids: [], role_ids: []
    )
  end
end
