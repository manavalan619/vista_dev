class StaffMember::Update
  prepend SimpleCommand

  def initialize(staff_member, params)
    @staff_member = staff_member
    @params = params
  end

  def call
    update
  end

  private

  def update
    return true if @staff_member.update(@params)
    @staff_member.errors.map { |key, value| errors.add(key, value) }
  end
end
