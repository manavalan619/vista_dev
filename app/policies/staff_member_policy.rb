class StaffMemberPolicy < ApplicationPolicy
  def management_login?
    manager? || admin?
  end

  def manage?
    manager?
  end

  def index?
    manager?
  end

  def new?
    organisation_manager?
  end

  def show?
    organisation_manager?
  end

  def edit?
    organisation_manager?
  end

  def create?
    organisation_manager?
  end

  def update?
    organisation_manager?
  end

  def invite?
    organisation_admin?
  end

  def destroy?
    return false if user == record
    organisation_admin?
  end

  def suspend?
    case record.class
    when Admin, BranchManager
      organisation_admin?
    else
      organisation_manager?
    end
  end

  def unsuspend?
    suspend?
  end

  class Scope < Scope
    def resolve
      if user.is_a? Admin
        scope.where(organisation_id: user.organisation_id)
      else
        scope.joins(:assigned_branches).where(branches: { id: user.assigned_branch_ids })
      end
    end
  end
end
