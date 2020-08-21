class StaffMember::Management::Authenticate
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    staff_member
  end

  private

  attr_accessor :email, :password

  def staff_member
    staff_member = StaffMember.management.find_by_email(email)
    valid_password = staff_member&.valid_password?(password)
    active_for_authentication = staff_member&.active_for_authentication?

    if valid_password && active_for_authentication
      return staff_member
    elsif valid_password && !active_for_authentication
      # TODO: use better response
      errors.add :staff_member_authentication, 'Disabled'
      return nil
    end

    errors.add :staff_member_authentication, 'Invalid credentials'
    nil
  end
end
