class UserPolicy < ApplicationPolicy
  def index?
    user.is_a? StaffMember
  end

  def revoke_all?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
