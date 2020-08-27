web: rails server
rpush: bundle exec rpush start -e $RACK_ENV -f
worker: bundle exec sidekiq
release: rake db:migrate
