# TODO/FIXME: remove?
class Partner::Update
  prepend SimpleCommand

  def initialize(partner, params)
    @partner = partner
    @params = params
  end

  def call
    update
  end

  private

  def update
    errors.add(:partner_profil_update, 'could not update partner profile') unless @partner.update(@params)
  end
end
