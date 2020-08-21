class BusinessUnitPolicy < ApplicationPolicy
  def index?
    manager?
  end

  def new?
    admin?
  end

  def show?
    organisation_manager?
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
      scope.where(organisation_id: user.organisation_id)
    end
  end

  private

  def organisation_manager?
    return false unless manager?
    user.organisation == record.organisation
  end

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
