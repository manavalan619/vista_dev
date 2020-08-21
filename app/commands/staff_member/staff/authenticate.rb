class StaffMember::Staff::Authenticate
  prepend SimpleCommand

  attr_accessor :employee_id, :pin

  def initialize(employee_id:, pin:, organisation:)
    @employee_id = employee_id
    @pin = pin
    @organisation = organisation
  end

  def call
    staff_member = @organisation.staff_members.find_by(employee_id: employee_id)
    valid_pin = staff_member&.valid_pin?(pin)
    active_for_authentication = staff_member&.active_for_authentication?

    if valid_pin && active_for_authentication
      return staff_member
    elsif valid_pin && !active_for_authentication
      if staff_member.suspended?
        errors.add :account, 'Suspended'
      elsif staff_member.archived?
        errors.add :account, 'Archived'
      else
        errors.add :account, 'Unconfirmed'
      end
      return nil
    end

    errors.add :account, 'Invalid credentials'
    nil
  end
end
