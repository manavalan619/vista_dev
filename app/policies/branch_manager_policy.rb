class BranchManagerPolicy < StaffMemberPolicy
  def manage?
    admin?
  end

  def destroy?
    organisation_admin?
  end

  def show?
    organisation_admin?
  end

  def edit?
    organisation_admin?
  end

  def new?
    organisation_admin?
  end
end
