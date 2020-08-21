if Rails.env.staging? || Rails.env.production?
  Aws::CF::Signer.configure do |config|
    # config.key_path = '/path/to/keyfile.pem'
    # or
    config.key = ENV.fetch('CLOUDFRONT_PRIVATE_KEY')
    config.key_pair_id = ENV.fetch('CLOUDFRONT_ACCESS_KEY_ID')
    config.default_expires = 3600
  end
end
