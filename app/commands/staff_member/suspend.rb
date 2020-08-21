class StaffMember::Suspend
  prepend SimpleCommand

  def initialize(staff_member)
    @staff_member = staff_member
  end

  def call
    return true if @staff_member.suspend
    @staff_member.errors.map { |key, value| errors.add(key, value) }
  end
end
