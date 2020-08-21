class StaffMember::Authenticate
  prepend SimpleCommand

  attr_accessor :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    # TODO: this should also authenticate against access privs
    # for the request
    # e.g. a staff member cannot sign into the admin app....
    staff_member = StaffMember.find_by_email(email)
    return staff_member if staff_member&.valid_password?(password)

    errors.add :staff_member_authentication, 'Invalid credentials'
    nil
  end
end
