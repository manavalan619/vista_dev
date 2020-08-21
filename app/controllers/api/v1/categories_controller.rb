module Api::V1
  class CategoriesController < Api::V1::BaseController
    before_action :find_category, except: %i[index]

    has_scope :in_category, as: :category

    def index
      @categories = apply_scopes(Category).includes(:photo)
      render json: @categories if stale?(@categories)
    end

    def show
      authorize @category
      render json: @category if stale?(@category)
    end

    private

    def find_category
      @category = Category.find(params[:id])
    end
  end
end
