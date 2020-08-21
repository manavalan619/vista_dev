class ApiConstraints
  def initialize
    @subdomains = %w[api api-staging vistadevapi]
  end

  def matches?(request)
    return true if request.domain == 'ngrok.io'
    @subdomains.include?(request.subdomain)
  end
end
