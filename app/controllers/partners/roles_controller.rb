class Partners::RolesController < Partners::BaseController
  before_action :set_business_unit
  before_action :set_role, only: %i[show edit update destroy]
  before_action :find_new_role, only: :destroy

  def index
    @roles = policy_scope(Role).page(params[:page])
    authorize @roles
  end

  def show
    redirect_to [:edit, :partners, @business_unit, @role]
  end

  def new
    @role = @business_unit.roles.new
  end

  def create
    @role = @business_unit.roles.new(role_params)
    authorize @role
    if @role.save
      redirect_to [:partners, @business_unit, :roles],
                  notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @role
    if @role.update(role_params)
      redirect_to [:partners, @business_unit, :roles],
                  success: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @role
    assign_new_role
    @role.destroy
    redirect_to [:partners, @business_unit, :roles],
                success: 'Role was successfully destroyed.'
  end

  private

  def set_business_unit
    @business_unit = policy_scope(BusinessUnit).find(params[:business_unit_id])
  end

  def set_role
    @role = policy_scope(Role).find(params[:id])
  end

  def find_new_role
    @new_role = policy_scope(Role).find_by id: params[:replace_with]
    return if @new_role.present?

    redirect_to [:edit, :partners, @business_unit, @role],
                error: 'Please specify replacement role'
  end

  def assign_new_role
    StaffMember.joins(:roles).where(roles: { id: @role }).find_each do |sm|
      sm.roles << @new_role
    end
  end

  def role_params
    params.require(:role).permit(
      :name, :business_unit_id,
      preference_structure_left: %i[id position],
      preference_structure_right: %i[id position],
      top_questions_data: %i[id position],
      interactions: [], member_request_type_ids: []
    )
  end
end
