class Partners::Staff::BranchManagersController < Partners::BaseController
  before_action :set_branch_manager, only: %i[show edit update destroy]

  def index
    @branch_managers = policy_scope(BranchManager)
    authorize @branch_managers
  end

  def show
    redirect_to [:edit, :partners, @branch_manager]
  end

  def new
    @branch_manager = current_organisation.branch_managers.new
    authorize @branch_manager
  end

  def edit
    authorize @branch_manager
  end

  def create
    @branch_manager = current_organisation.branch_managers.new(branch_manager_params)
    authorize @branch_manager

    if @branch_manager.save
      redirect_to %i[partners branch_managers], success: 'Branch manager was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @branch_manager
    if @branch_manager.update(branch_manager_params)
      redirect_to %i[partners branch_managers], success: 'Branch manager was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @branch_manager
    @branch_manager.destroy
    redirect_to %i[partners branch_managers], success: 'Branch manager was successfully removed.'
  end

  private

  def set_branch_manager
    @branch_manager = current_organisation.branch_managers.find(params[:id])
  end

  def branch_manager_params
    params.require(:branch_manager).permit(
      :first_name, :last_name, :email, :mobile_number, :employee_id,
      :pin, :pin_confirmation, assigned_branch_ids: [], role_ids: []
    )
  end
end
