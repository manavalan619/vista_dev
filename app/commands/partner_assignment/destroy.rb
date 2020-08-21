class PartnerAssignment::Destroy
  prepend SimpleCommand

  def initialize(partner, target)
    @partner_assignment = target.partner_assignments.find_by(partner: partner)
  end

  def call
    # errors.add(:partner_assignment, 'could not assign partner') unless assign_partner
    unassign_partner
  end

  private

  def unassign_partner
    return true if @partner_assignment.destroy
    @partner_assignment.errors.map { |key, value| errors.add(key, value) }
  end
end
