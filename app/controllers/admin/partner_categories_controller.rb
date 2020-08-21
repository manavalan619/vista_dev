class Admin::PartnerCategoriesController < Admin::BaseController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @partner_categories = PartnerCategory.page(params[:page])
  end

  def show
    redirect_to [:edit, :admin, @partner_category]
  end

  def new
    @partner_category = PartnerCategory.new
    @partner_category.build_photo
  end

  def edit
    @partner_category.photo || @partner_category.build_photo
  end

  def create
    @partner_category = PartnerCategory.new(category_params)

    if @partner_category.save
      redirect_to admin_partner_categories_path, success: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @partner_category.update(category_params)
      redirect_to admin_partner_categories_path, success: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @partner_category.destroy
    redirect_to admin_partner_categories_path, success: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @partner_category = PartnerCategory.find(params[:id])
  end

  def category_params
    params.require(:partner_category).permit(permitted_attributes)
  end

  def permitted_attributes
    [:title, photo_attributes: photo_attributes]
  end

  def photo_attributes
    %i[id image remote_image_url image_cache _destroy]
  end
end
