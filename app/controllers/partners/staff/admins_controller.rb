class Partners::Staff::AdminsController < Partners::BaseController
  before_action :set_admin, only: %i[show edit update destroy]

  def index
    @admins = policy_scope(Admin)
    authorize @admins
  end

  def show
    redirect_to [:edit, :partners, @admin]
  end

  def new
    @admin = current_organisation.admins.new
    authorize @admin
  end

  def edit
    authorize @admin
  end

  def create
    @admin = current_organisation.admins.new(admin_params)
    authorize @admin

    if @admin.save
      redirect_to %i[partners admins], success: 'Admin was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @admin
    if @admin.update(admin_params)
      redirect_to %i[partners admins], success: 'Admin was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @admin
    @admin.destroy
    redirect_to %i[partners admins], success: 'Admin was successfully removed.'
  end

  private

  def set_admin
    @admin = current_organisation.admins.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(
      :first_name, :last_name, :email, :mobile_number, :employee_id,
      :pin, :pin_confirmation, assigned_branch_ids: [], role_ids: []
    )
  end
end
