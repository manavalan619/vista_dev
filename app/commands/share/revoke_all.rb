class Share::RevokeAll
  prepend SimpleCommand

  def initialize(user)
    @user = user
  end

  def call
    return true if @user.shares.revoke_all
    @user.errors.map { |k, v| errors.add(k, v) }
    false
  end
end
