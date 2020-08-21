# TODO/FIXME: remove?
class Partner::Destroy
  prepend SimpleCommand

  def initialize(partner)
    @partner = partner
  end

  def call
    destroy
  end

  private

  def destroy
    errors.add(:removing_account, 'cannot remove account of partner') unless @partner.destroy
  end
end
