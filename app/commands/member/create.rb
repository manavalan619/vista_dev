class Member::Create
  prepend SimpleCommand

  def initialize(member, user_attributes)
    @member = member
    @user = User.new(user_attributes)
  end

  def call
    generate_vista_member_id
    errors.add(:member_registration, 'could not create an account') unless create_account
  end

  private

  def create_account
    if @member.save
      @user.subject = @member
      if @user.save
        true
      else
        @member.delete
        @member.user = @user
        false
      end
    else
      false
    end
  end

  def generate_vista_member_id
    @member.vista_member_id = loop do
      token = random_token
      break token unless Member.exists?(vista_member_id: token)
    end
  end

  def random_token
    format('%016d', SecureRandom.random_number(10**16))
  end
end
