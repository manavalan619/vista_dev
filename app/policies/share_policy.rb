class SharePolicy < ApplicationPolicy
  def request?
    true
  end

  def authorise?
    share_user?
  end

  def revoke?
    share_user?
  end

  def destroy?
    share_user?
  end

  private

  def share_user?
    @record.user == user
  end
end
