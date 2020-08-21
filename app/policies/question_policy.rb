class QuestionPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def unlocked?
    user?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user?
    user.is_a? User
  end
end
