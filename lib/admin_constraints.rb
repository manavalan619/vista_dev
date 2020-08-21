class AdminConstraints
  def initialize
    @subdomains = %w[admin admin-staging]
  end

  def matches?(request)
    @subdomains.include?(request.subdomain)
  end
end
