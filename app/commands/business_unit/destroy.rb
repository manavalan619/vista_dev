class BusinessUnit::Destroy
  prepend SimpleCommand

  def initialize(business_unit)
    @business_unit = business_unit
  end

  def call
    destroy
  end

  private

  def destroy
    return true if @business_unit.destroy
    errors.add(:removing_business_unit, 'cannot remove business unit')
  end
end
