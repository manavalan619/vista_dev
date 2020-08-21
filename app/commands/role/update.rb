class Role::Update
  prepend SimpleCommand

  def initialize(role, params)
    @role = role
    @params = params
  end

  def call
    return true if @role.update(@params)
    @role.errors.map { |key, value| errors.add(key, value) }
  end
end
