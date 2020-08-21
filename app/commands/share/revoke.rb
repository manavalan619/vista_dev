class Share::Revoke
  prepend SimpleCommand

  def initialize(branch:, user:)
    @share = Share.find_by(branch: branch, user: user, status: 'authorised')
  end

  def call
    return @share if @share.revoke!
    @share.errors.map { |k, v| errors.add(k, v) }
    @share
  end
end
