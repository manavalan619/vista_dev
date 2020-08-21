class BusinessUnit::Create
  prepend SimpleCommand

  def initialize(business_unit)
    @business_unit = business_unit
  end

  def call
    create_account
  end

  private

  def create_account
    return true if @business_unit.save
    @business_unit.errors.map { |key, value| errors.add(key, value) }
  end
end
