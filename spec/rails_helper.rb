require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
require 'pundit/rspec'
require 'database_cleaner'
require 'paper_trail/frameworks/rspec'

# Add folder for defining helper methods in rspec
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Faker::Config.locale = 'en-GB'

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include ActiveJob::TestHelper

  config.define_derived_metadata(file_path: Regexp.new('/spec/serializers/')) do |metadata|
    metadata[:type] = :serializer
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) { Rails.cache.clear }

  config.before(:each, type: :serializer) do
    allow_any_instance_of(ActiveModel::Serializer).to receive(:scope).and_return(
      OpenStruct.new(current_user: create(:user))
    )
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after(:each) do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  # config.include Devise::Test::IntegrationHelpers, type: :feature
  config.extend ControllerMacros, type: :controller
  config.include RequestHelpers, type: :request
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

class << ActionView::LookupContext::DetailsKey
  def clear
  end
end
