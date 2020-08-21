class Share::Request
  prepend SimpleCommand

  def initialize(branch:, user:, via: nil)
    @share = Share.new(branch_id: branch.to_param, user_id: user.to_param, via: via)
    @existing_share = Share.find_by(
      branch_id: branch,
      user_id: user,
      status: %w[requested authorised]
    )
  end

  def call
    if @existing_share
      errors.add(:status, 'Already requested') if requested?
      errors.add(:status, 'Already authorised') if authorised?
      return false
    end

    return @share if @share.request!
    @share.errors.map { |k, v| errors.add(k, v) }
    @share
  end

  private

  def requested?
    @existing_share.status == 'requested'
  end

  def authorised?
    @existing_share.status == 'authorised'
  end
end
