# %w[member_ios partner_ios].each do |app_name|
#   path = Rails.root.join('certificates', "#{app_name}.pem")
#
#   app = Rpush::Apns::App.find_or_initialize_by name: app_name
#   app.environment = Rails.env.production? ? 'production' : 'development'
#   app.certificate = File.read(path)
#   app.save!
# end

# TODO: add auth keys
# %w[member_android partner_android].each do |app_name|
#   app = Rpush::Gcm::App.find_or_initialize_by name: app_name
#   app.auth_key = ''
#   app.connections = 1
#   app.save!
# end
