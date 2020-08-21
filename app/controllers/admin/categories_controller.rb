class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.roots.page(params[:page]).includes(:photo)
  end

  def show
    redirect_to [:edit, :admin, @category]
  end

  def new
    @category = Category.new
    @category.build_photo
  end

  def edit
    @category.photo || @category.build_photo
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, success: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, success: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, success: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :title, :description, :parent_id, :initial, :text_style,
      visibility_conditions: %i[question_id answer],
      photo_attributes: %i[id image remote_image_url image_cache _destroy]
    )
  end
end
