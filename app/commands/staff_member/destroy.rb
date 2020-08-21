class StaffMember::Destroy
  prepend SimpleCommand

  def initialize(staff_member)
    @staff_member = staff_member
  end

  def call
    destroy
  end

  private

  def destroy
    # TODO: use locales?
    return true if @staff_member.destroy
    errors.add(:removing_account, 'cannot remove staff member')
  end
end
