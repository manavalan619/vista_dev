web: bundle exec rails s
rpush: bundle exec rpush start -e $RACK_ENV -f
worker: bundle exec sidekiq
release: rake db:migrate