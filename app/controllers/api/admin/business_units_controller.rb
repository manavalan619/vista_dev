module Api::Admin
  class BusinessUnitsController < Api::Admin::ApiController
    before_action :find_business_unit, except: [:index, :create]

    def index
      @business_units = policy_scope(BusinessUnit)
      authorize @business_units
      render json: @business_units if stale?(@business_units)
    end

    def show
      authorize @business_unit
      render json: @business_unit if stale?(@business_unit)
    end

    def create
      @business_unit = BusinessUnit.new(business_unit_params)
      @business_unit.organisation_id = current_user.organisation_id
      authorize @business_unit
      if BusinessUnit::Create.call(@business_unit).success?
        render json: @business_unit, status: 201
      else
        render json: @business_unit, status: 422
      end
    end

    def update
      authorize @business_unit
      if BusinessUnit::Update.call(@business_unit, business_unit_params).success?
        render json: @business_unit, status: 200
      else
        render json: @business_unit, status: 422
      end
    end

    def destroy
      authorize @business_unit
      if BusinessUnit::Destroy.call(@business_unit).success?
        render json: '', status: 204
      else
        render json: '', status: 422
      end
    end

    private

    def business_unit_params
      params.require(:business_unit).permit(:name)
    end

    def find_business_unit
      @business_unit = policy_scope(BusinessUnit).find(params[:id])
    end
  end
end
