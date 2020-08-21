class AdminPolicy < StaffMemberPolicy
  def manage?
    admin?
  end

  def show?
    organisation_admin?
  end

  def edit?
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

  def invite?
    admin?
  end
end
