class User::Update
  prepend SimpleCommand

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    update
  end

  private

  def update
    return true if @user.update(@params)
    @user.errors.map { |key, value| errors.add(key, value) }
  end
end
