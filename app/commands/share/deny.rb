class Share::Deny
  prepend SimpleCommand

  def initialize(branch:, user:)
    @share = Share.find_by(branch: branch, user: user, status: 'requested')
  end

  def call
    return @share if @share.deny!
    @share.errors.map { |k, v| errors.add(k, v) }
    @share
  end
end
