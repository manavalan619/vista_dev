class Member::Update
  prepend SimpleCommand

  def initialize(member, params)
    @member = member
    @params = params
  end

  def call
    update
  end

  private

  def update
    errors.add(:member_profile_update, 'could not update member profile') unless @member.update(@params)
  end
end
