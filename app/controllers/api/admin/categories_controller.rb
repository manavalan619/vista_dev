module Api::Admin
  class CategoriesController < Api::Admin::ApiController
    before_action :find_category, except: %i[index create]

    def index
      @categories = policy_scope(Category)
      render json: @categorys if stale?(@categories)
    end

    def show
      authorize @category
      render json: @category if stale?(@category)
    end

    def create
      @category = Category.new(category_params)
      authorize @category
      if Category::Create.call(@category).success?
        render json: @category, status: 201
      else
        render json: @category, status: 422
      end
    end

    def update
      authorize @category
      if Category::Update.call(@category, category_params).success?
        render json: @category, status: 200
      else
        render json: @category, status: 422
      end
    end

    def destroy
      authorize @category
      if Category::Destroy.call(@category).success?
        head 204
      else
        head 422
      end
    end

    private

    def category_params
      params.require(:category).permit(:parent, :name)
    end

    def find_category
      @category = Category.find(params[:id])
    end
  end
end
