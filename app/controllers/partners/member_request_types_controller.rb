class Partners::MemberRequestTypesController < Partners::BaseController
  before_action :set_business_unit
  before_action :set_request_type, only: %i[edit update destroy]

  def index
    @request_types = policy_scope(MemberRequestType).page(params[:page])
    authorize @request_types
  end

  def new
    @request_type = @business_unit.member_request_types.new
  end

  def create
    @request_type = @business_unit.member_request_types.new(member_request_type_params)
    authorize @request_type
    if @request_type.save
      redirect_to [:partners, @business_unit, :member_request_types],
                  notice: 'Request type was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @request_type
    if @request_type.update(member_request_type_params)
      redirect_to [:partners, @business_unit, :member_request_types],
                  success: 'Request type was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @request_type
    @request_type.destroy
    redirect_to [:partners, @business_unit, :member_request_types],
                success: 'Request type was successfully destroyed.'
  end

  private

  def set_business_unit
    @business_unit = policy_scope(BusinessUnit).find(params[:business_unit_id])
  end

  def set_request_type
    @request_type = policy_scope(MemberRequestType).find(params[:id])
  end

  def member_request_type_params
    params.require(:member_request_type).permit(:name)
  end
end
