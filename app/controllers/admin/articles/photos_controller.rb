class Admin::Articles::PhotosController < Admin::BaseController
  before_action :find_article

  def create
    @photo = @article.photos.new(photo_params)

    if @photo.save
      render json: @photo, status: :created
    else
      render json: @photo, status: :unprocessable_entity
    end
  end

  private

  def find_article
    @article = Article.find params[:id]
  end

  def photo_params
    params.require(:photo).permit(:image)
  end
end
