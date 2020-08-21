require_relative 'boot'

require 'rails/all'
# require 'rails'
# require 'active_model/railtie'
# require 'active_job/railtie'
# require 'active_record/railtie'
# require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_view/railtie'
require 'sprockets/es6'

Bundler.require(*Rails.groups)

module VistaPlatform
  class Application < Rails::Application
    config.load_defaults 5.1
    config.generators.system_tests = nil
    config.autoload_paths += %W[#{config.root}/config/routes]
    config.middleware.use Rack::Deflater
    config.middleware.insert_before 0, Rack::Cors, debug: Rails.env.development?, logger: (-> { Rails.logger }) do
      allow do
        origins %w[admin.vista.test admin.getvista.co
                   admin-staging.getvista.co partners-staging.vista.co
                   partners.vista.test partners.getvista.co]
        resource '/public/*', headers: :any, methods: :get
        resource '/assets/*', headers: :any, methods: :get
        # resource '*', headers: :any, methods: %i[get post options]
      end
    end
    unless Rails.env.development? || Rails.env.test?
      config.action_cable.allowed_request_origins = [
        %r{http(s*):\/\/admin.getvista.co}
      ]
    end
    config.active_job.queue_adapter = :sidekiq
  end
end
