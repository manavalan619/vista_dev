class Admin::BusinessUnitsController < Admin::BaseController
  before_action :set_organisation
  before_action :set_business_unit, only: [:show, :edit, :update, :destroy]

  def index
    @business_units = @organisation.business_units.page(params[:page])
  end

  def show
    redirect_to [:edit, :admin, @organisation, @business_unit]
  end

  def new
    @business_unit = @organisation.business_units.new
  end

  def edit
  end

  def create
    @business_unit = @organisation.business_units.new(business_unit_params)

    if @business_unit.save
      redirect_to admin_organisation_business_units_path, success: 'Business unit was successfully created.'
    else
      render :new
    end
  end

  def update
    if @business_unit.update(business_unit_params)
      redirect_to admin_organisation_business_units_path, success: 'Business unit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @business_unit.destroy
    redirect_to admin_organisation_business_units_path, success: 'Business unit was successfully destroyed.'
  end

  private

  def set_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end

  def set_business_unit
    @business_unit = @organisation.business_units.find(params[:id])
  end

  def business_unit_params
    params.require(:business_unit).permit(:name)
  end
end
