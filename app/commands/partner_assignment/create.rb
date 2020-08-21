class PartnerAssignment::Create
  prepend SimpleCommand

  def initialize(partner, target)
    @partner_assignment = target.partner_assignments.new(partner: partner)
  end

  def call
    # errors.add(:partner_assignment, 'could not assign partner') unless assign_partner
    assign_partner
  end

  private

  def assign_partner
    return true if @partner_assignment.save
    @partner_assignment.errors.map { |key, value| errors.add(key, value) }
  end
end
