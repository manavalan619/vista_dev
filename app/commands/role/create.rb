class Role::Create
  prepend SimpleCommand

  def initialize(role)
    @role = role
  end

  def call
    return true if @role.save
    @role.errors.map { |key, value| errors.add(key, value) }
  end
end
