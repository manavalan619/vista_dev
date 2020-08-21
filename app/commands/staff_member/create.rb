class StaffMember::Create
  prepend SimpleCommand

  def initialize(staff_member, params)
    @staff_member = staff_member
    @staff_member.assign_attributes params
  end

  def call
    create_account
  end

  private

  def create_account
    return true if @staff_member.save
    @staff_member.errors.map { |key, value| errors.add(key, value) }
  end

  def random_token
    format('%016d', SecureRandom.random_number(10**16))
  end
end
