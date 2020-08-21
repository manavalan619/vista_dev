module Partners::BusinessUnitsHelper
  def business_units_for_select
    return current_organisation.business_units if current_staff_member.admin?
    current_staff_member.assigned_business_units
  end
end
