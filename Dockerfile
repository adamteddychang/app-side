FROM ruby:3.1.2-alpine3.16

RUN apk add --no-cache --update yarn \
                                imagemagick \
                                openrc \
                                nodejs \
                                git \
                                postgresql \
                                postgresql-dev \
                                postgresql-client \
                                build-base \
                                inotify-tools \
                                less \
                                ncurses 
                                
RUN apk add gcompat
RUN apk add flatpak

RUN mkdir -p /app
WORKDIR /app

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true

ARG APP_ENV
ARG AWS_DEFAULT_REGION
ARG RDS_PORT
ARG RDS_DB_NAME
ARG RDS_USERNAME
ARG RDS_HOSTNAME
ARG RDS_PASSWORD
ARG REDIS_URL
ARG ACCESS_KEY_ID
ARG SECRET_ACCESS_KEY
ARG API_KEY

COPY . ./
RUN bundle install --jobs 20 --retry 5 --without development test

COPY ./docker/nginx/production/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/production/sites-enabled /etc/nginx/sites-enabled

EXPOSE 8081

RUN mkdir tmp tmp/pids && touch log/access.log log/error.log
# RUN whenever --update-crontab
RUN bundle exec rake assets:precompile

CMD bundle exec rails db:migrate && \
    nginx && \
    # crond -b && \
    # ./bin/delayed_job start && \
    # bundle exec rpush start -e production && \
    bundle exec puma -C ./docker/puma/production.rb
