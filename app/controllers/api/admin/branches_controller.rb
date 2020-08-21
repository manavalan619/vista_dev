module Api::Admin
  class BranchesController < Api::Admin::ApiController
    before_action :find_unit
    before_action :find_branch, except: [:index, :create]

    def index
      @branches = @business_unit.branches
      authorize @branches
      render json: @branches if stale?(@branches)
    end

    def show
      authorize @branch
      render json: @branch if stale?(@branch)
    end

    def create
      @branch = @business_unit.branches.new(branch_params)
      authorize @branch
      if Branch::Create.call(@branch).success?
        render json: @branch, status: 201
      else
        render json: @branch, status: 422
      end
    end

    def update
      authorize @branch
      if Branch::Update.call(@branch, branch_params).success?
        render json: @branch, status: 200
      else
        render json: @branch, status: 422
      end
    end

    def destroy
      authorize @branch
      if Branch::Destroy.call(@branch).success?
        head :no_content # NB: this implies status 204
      else
        head 422
      end
    end

    private

    def branch_params
      params.require(:branch).permit(:name, :address, :telephone, :email, :branch_info, :image)
    end

    def find_branch
      @branch = @business_unit.branches.find(params[:id])
    end

    def find_unit
      @business_unit = policy_scope(BusinessUnit).find(params[:unit_id])
    end
  end
end
