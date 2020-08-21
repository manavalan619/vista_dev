module Api::V1
  class ContentCategoriesController < Api::V1::BaseController
    def index
      @content_categories = ContentCategory.all
      render json: @content_categories if stale?(@content_categories)
    end
  end
end
