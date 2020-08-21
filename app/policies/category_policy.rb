class CategoryPolicy < ApplicationPolicy
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

  def questions?
    user?
  end

  def unlocked_questions?
    user?
  end

  class Scope
    attr_reader :record, :scope

    def initialize(record, scope)
      @record = record
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private

  def admin?
    user.is_a? Admin
  end

  def user?
    user.is_a? User
  end
end
