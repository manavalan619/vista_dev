class Admin::CitiesController < Admin::BaseController
  before_action :set_city, only: %i[show edit update destroy]

  def index
    @cities = City.page(params[:page])
  end

  def show
    redirect_to [:edit, :admin, @city]
  end

  def new
    @city = City.new
    @city.build_photo
  end

  def edit
    @city.photo || @city.build_photo
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to admin_cities_path, success: 'City was successfully created.'
    else
      @city.photo || @city.build_photo
      render :new
    end
  end

  def update
    if @city.update(city_params)
      redirect_to admin_cities_path, success: 'City was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @city.destroy
    redirect_to admin_cities_path, success: 'City was successfully destroyed.'
  end

  private

  def set_city
    @city = City.find(params[:id])
  end

  def city_params
    params.require(:city).permit(permitted_attributes)
  end

  def permitted_attributes
    [:name, :status, photo_attributes: photo_attributes]
  end

  def photo_attributes
    %i[id image remote_image_url image_cache _destroy]
  end
end
