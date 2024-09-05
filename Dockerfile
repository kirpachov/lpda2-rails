# syntax=docker/dockerfile:1
FROM ruby:3.1.3 AS lpda2-rails
RUN apt update -qq && apt install -y postgresql-client ruby-vips
WORKDIR /lpda2
COPY Gemfile /lpda2/Gemfile
COPY Gemfile.lock /lpda2/Gemfile.lock
RUN bundle install
RUN bundle exec rails db:create db:migrate db:seed

# EXPOSE 3050

CMD rm -f tmp/pids/server.pid && bundle exec rails s -p 3050 -b '0.0.0.0'
