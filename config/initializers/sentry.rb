unless Rails.env.test? || Rails.env.development?
  Raven.configure do |config|
    # config.environments = %w[staging production]
    config.dsn = ENV['SENTRY_DSN']
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    config.async = ->(event) { SentryJob.perform_later(event) }

    # TODO: worth implementing this in case of failure to report
    # config.transport_failure_callback = lambda { |event|
    #   AdminMailer.email_admins("Oh god, it's on fire!", event).deliver_later
    # }
  end
end
