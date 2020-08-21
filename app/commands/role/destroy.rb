class Role::Destroy
  prepend SimpleCommand

  def initialize(role)
    @role = role
  end

  def call
    return true if @role.destroy
    errors.add(:removing_role, 'cannot remove role')
  end
end
