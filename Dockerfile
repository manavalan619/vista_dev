#FROM adgud2/ruby-rvm:latest
ARG RVM_RUBY_VERSIONS="2.5.1"
FROM msati/docker-rvm:latest
# MAINTAINER Paweł Placzyński <placzynski.pawel@gmail.com>

ENV APP_DIRECTORY /www
RUN mkdir -p $APP_DIRECTORY

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn
RUN apt-get install -y ruby-dev build-essential
RUN apt-get install -y postgresql-client libpq5 libpq-dev
RUN gem install pg
WORKDIR $APP_DIRECTORY

RUN echo 'alias b="bundle exec"' > ~/.profile

COPY Gemfile Gemfile.lock .ruby-version .ruby-gemset ./
RUN /bin/bash -l -c 'rvm . do gem install bundler && echo "gem: --no-rdoc --no-ri" >> ".gemrc" && bundle install'
