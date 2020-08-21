class PartnerConstraints
  def initialize
    @subdomains = %w[partners partners-staging]
  end

  def matches?(request)
    @subdomains.include?(request.subdomain)
  end
end
