class BranchPolicy < ApplicationPolicy
  def index?
    manager?
  end

  def show?
    organisation_admin?
  end

  def create?
    organisation_admin?
  end

  def update?
    organisation_admin?
  end

  def destroy?
    organisation_admin?
  end

  class Scope < Scope
    def resolve
      scope.joins(:organisation).where(organisations: {
        id: user.organisation_id
      })
    end
  end

  private

  def organisation_admin?
    return false unless admin?
    user.organisation == record.organisation
  end

  def admin?
    user.is_a? Admin
  end

  def manager?
    [Admin, BranchManager].include? user.class
  end
end
