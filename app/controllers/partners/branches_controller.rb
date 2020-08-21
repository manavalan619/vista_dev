class Partners::BranchesController < Partners::BaseController
  before_action :set_business_unit
  before_action :set_branch, only: %i[show edit update destroy]

  def index
    @branches = @business_unit.branches.page(params[:page])
  end

  def show
    redirect_to [:edit, :partners, @business_unit, @branch]
  end

  def new
    @branch = @business_unit.branches.new
    @branch.build_photo
    @branch.build_address
  end

  def edit
    @branch.photo || @branch.build_photo
    @branch.address || @branch.build_address
  end

  def create
    @branch = @business_unit.branches.new(branch_params)

    if @branch.save
      redirect_to [:partners, @business_unit, :branches], success: 'Branch was successfully created.'
    else
      render :new
    end
  end

  def update
    if @branch.update(branch_params)
      redirect_to [:partners, @business_unit, :branches], success: 'Branch was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @branch.destroy
    redirect_to [:partners, @business_unit, :branches], success: 'Branch was successfully destroyed.'
  end

  private

  def set_business_unit
    @business_unit = policy_scope(BusinessUnit).find(params[:business_unit_id])
  end

  def set_branch
    @branch = @business_unit.branches.find(params[:id])
  end

  def branch_params
    params.require(:branch).permit(
      :name, :email, :telephone, :branch_info, :booking_url, category_ids: [],
      photo_attributes: %i[id image remote_image_url image_cache _destroy],
      address_attributes: %i[
        id label line1 line2 city_id county postcode country phone latitude
        longitude _destroy
      ]
    )
  end
end
