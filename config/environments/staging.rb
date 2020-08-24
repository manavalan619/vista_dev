Rails.application.configure do
  config.cache_store = :dalli_store,
                       (ENV['MEMCACHIER_SERVERS'] || '').split(','),
                       {
                         username: ENV['MEMCACHIER_USERNAME'],
                         password: ENV['MEMCACHIER_PASSWORD'],
                         failover: true,
                         socket_timeout: 1.5,
                         socket_failure_delay: 0.2,
                         down_retry_delay: 60,
                         pool_size: 5
                       }
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.read_encrypted_secrets = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  # config.action_mailer.default_url_options = {
  #   host: ENV['CLIENT_URL'] || 'getvista.co'
  # }

  config.action_controller.asset_host = ENV.fetch('ASSET_HOST')
  config.action_mailer.default_url_options = {
    host: ENV.fetch('HOST_NAME') { "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" }
  }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name: ENV.fetch('SENDGRID_USERNAME'),
    password: ENV.fetch('SENDGRID_PASSWORD'),
    domain: 'getvista.co',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.assets.compile = false

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_storage.service = :local
  config.action_cable.allowed_request_origins = [/https:\/\/([a-z].)*herokuapp.com/]
end
