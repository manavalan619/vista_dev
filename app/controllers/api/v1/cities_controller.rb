module Api::V1
  class CitiesController < Api::V1::BaseController
    def index
      @cities = City.includes(:photo).not_disabled.page(params[:page])
      render json: @cities if stale?(@cities)
    end
  end
end
