class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_FROM_ADDRESS'] || 'no-reply@getvista.co'
  layout 'mailer'
end
