class User::Register
  prepend SimpleCommand

  attr_accessor :email, :password

  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user.try(:authentication_token)
  end

  private

  def user
    user = User.create(@user_params)
    return user if user.persisted?
    user.errors.map { |key, value| errors.add(key, value) }
    nil
  end
end
