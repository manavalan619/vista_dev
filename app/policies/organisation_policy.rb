class OrganisationPolicy < ApplicationPolicy
  def show?
    member?
  end

  def create?
    false
  end

  def update?
    member?
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.where(id: user.organisation_id)
    end
  end

  private

  def member?
    user.organisation == record
  end
end
