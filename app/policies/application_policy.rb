class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    vista_admin?
  end

  def create?
    vista_admin?
  end

  def update?
    vista_admin?
  end

  def destroy?
    vista_admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(id: -1)
    end
  end

  private

  def staff_member?
    user.is_a?(StaffMember)
  end

  def admin?
    vista_admin? || user.is_a?(Admin)
  end

  def vista_admin?
    user.is_a?(VistaAdmin)
  end

  def manager?
    return true if vista_admin?
    return false if user.suspended_at?
    [BranchManager, Admin].include? user.class
  end

  def organisation_admin?
    return true if vista_admin?
    return false unless admin?
    user.organisation == record.organisation
  end

  def organisation_manager?
    return true if vista_admin?
    return false unless manager?
    user.organisation == record.organisation
  end
end
