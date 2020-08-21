class StaffMember::Unsuspend
  prepend SimpleCommand

  def initialize(staff_member)
    @staff_member = staff_member
  end

  def call
    return true if @staff_member.unsuspend
    @staff_member.errors.map { |key, value| errors.add(key, value) }
  end
end
