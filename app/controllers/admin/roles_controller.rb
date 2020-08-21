class Admin::RolesController < Admin::BaseController
  before_action :set_role, only: %i[show edit update destroy]
  before_action :find_new_role, only: :destroy

  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to @role, notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  def update
    if @role.update(role_params)
      redirect_to @role, notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    assign_new_role
    @role.destroy
    redirect_to roles_url, notice: 'Role was successfully destroyed.'
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def find_new_role
    @new_role = @role.organisation.roles.find_by id: params[:replace_with]
    return if @new_role.present?

    render json: { errors: [{ title: 'Please specify replacement role' }] },
           status: 422 and return
  end

  def assign_new_role
    StaffMember.joins(:roles).where(roles: { id: @role }).find_each do |sm|
      sm.roles << @new_role
    end
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
