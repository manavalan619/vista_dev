class BusinessUnit::Update
  prepend SimpleCommand

  def initialize(business_unit, params)
    @business_unit = business_unit
    @params = params
  end

  def call
    update
  end

  private

  def update
    return true if @business_unit.update(@params)
    @business_unit.errors.map { |key, value| errors.add(key, value) }
  end
end
