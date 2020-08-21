# rubocop:disable Bundler/OrderedGems
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'puma', '~> 3.7'
gem 'pg', '~> 0.18'
gem 'awesome_print'
gem 'paranoia'
gem 'hashids'
gem 'seedbank'
gem 'rpush'
gem 'bootsnap', require: false
gem 'has_scope'
gem 'rack-cors', require: 'rack/cors'
gem 'paper_trail'
gem 'graphql'
gem 'graphql_playground-rails'
gem 'graphiql-rails'
gem 'roo'
gem 'highline'
# gem 'active_record-mti' # PostgreSQL multi table inheritance
gem 'redis', '~> 3.0'
gem 'dalli'
gem 'connection_pool'
gem 'jsonb_accessor', '~> 1.0.0'
gem 'aasm'

# views
gem 'active_link_to'
gem 'cocoon'
gem 'country_select'
gem 'font-awesome-rails'
gem 'gretel'
gem 'kaminari'
gem 'simple_form'

# assets
gem 'bootstrap', '~> 4.0.0'
gem 'bulma-rails', '~> 0.6.2'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'sass-rails', '~> 5.0'
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'unobtrusive_flash', '>=3'
# gem 'webpacker-react', '~> 0.3.1'
gem 'webpacker', '~> 2.0' # NB: there is an issue compiling with version 3
gem 'react-rails'
gem 'remotipart'

# command objects
gem 'simple_command'

# authentication and authorisation
gem 'devise'
gem 'pundit'

# photos upload
gem 'carrierwave', '~> 1.2.2'
gem 'carrierwave-aws', github: 'sorentwo/carrierwave-aws'
gem 'mini_magick'
gem 'image_optim'
gem 'image_optim_pack'
gem 'carrierwave-imageoptim'
gem 'cloudfront-signer'

# api json serialization
gem 'active_model_serializers', '~> 0.10.0'

# nested categories
gem 'ancestry'

# Sidekiq / background jobs
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidekiq-cron'
gem 'activejob-cancel'

# Geo spatial support
gem 'geokit-rails'

# Error reporting / logging / monitoring
gem 'sentry-raven'
gem 'scout_apm'
gem 'pghero'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails'
  gem 'parallel_tests'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'terminal-notifier-guard'
  gem 'web-console', '>= 3.3.0'
  gem 'bullet'
  gem 'lol_dba'
  install_if -> { RUBY_PLATFORM =~ /darwin/ } do
    gem 'invoker', github: 'chrise86/invoker'
    gem 'terminal-notifier'
  end
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
  gem 'webmock'
  gem 'rspec_junit_formatter'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
