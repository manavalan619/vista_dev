class User::Authenticate
  prepend SimpleCommand

  attr_accessor :email, :password

  def initialize(email, password)
    @email = email.try(:downcase)
    @password = password
  end

  def call
    user = User.find_by_email(email)
    return user if user&.valid_password?(password)

    errors.add :user_authentication, 'Invalid credentials'
    nil
  end
end
