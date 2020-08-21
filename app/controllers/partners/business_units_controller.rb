class Partners::BusinessUnitsController < Partners::BaseController
  before_action :set_business_unit, only: %i[show edit update destroy]

  def index
    @business_units = policy_scope(BusinessUnit).page(params[:page])
    authorize @business_units
  end

  def show
    redirect_to [:partners, @business_unit, :branches]
    # @business_unit = policy_scope(BusinessUnit).includes(:branches).find(params[:id])
    # authorize @business_unit
    # @branches = @business_unit.branches.page(params[:page])
  end

  def new
    @business_unit = current_organisation.business_units.new
  end

  def create
    @business_unit = current_organisation.business_units.new(business_unit_params)
    authorize @business_unit
    if @business_unit.save
      redirect_to %i[partners business_units], notice: 'Unit was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @business_unit
    if @business_unit.update(business_unit_params)
      redirect_to %i[partners business_units], notice: 'Unit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @business_unit
    @business_unit.destroy
    redirect_to %i[partners business_units], notice: 'Unit was successfully destroyed.'
  end

  private

  def set_business_unit
    @business_unit = policy_scope(BusinessUnit).find(params[:id])
  end

  def business_unit_params
    params.require(:business_unit).permit(:name)
  end
end
