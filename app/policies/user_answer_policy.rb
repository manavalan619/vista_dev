class UserAnswerPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  private

  def user?
    record.user == user
  end
end
