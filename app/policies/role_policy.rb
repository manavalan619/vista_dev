class RolePolicy < ApplicationPolicy
  def manage?
    manager?
  end

  def index?
    manager?
  end

  def show?
    organisation_manager?
  end

  def create?
    organisation_manager?
  end

  def update?
    organisation_manager?
  end

  def destroy?
    organisation_manager?
  end

  class Scope < Scope
    def resolve
      scope.joins(:business_unit).where(
        business_units: { organisation_id: user.organisation_id }
      ).references(:business_unit)
    end
  end
end
