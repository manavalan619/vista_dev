class Share::Authorise
  prepend SimpleCommand

  def initialize(branch:, user:, via: nil)
    @share = Share.create_with(via: via).find_or_initialize_by(
      branch: branch,
      user: user,
      status: 'requested'
    )
  end

  def call
    return @share if @share.authorise!
    @share.errors.map { |k, v| errors.add(k, v) }
    @share
  end
end
