class Member::Destroy
  prepend SimpleCommand

  def initialize(member)
    @member = member
  end

  def call
    destroy
  end

  private

  def destroy
    errors.add(:removing_account, 'cannot remove account of member') unless @member.destroy
  end
end
