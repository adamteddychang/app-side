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
                                ncurses \
                                vim

RUN mkdir -p /app
WORKDIR /app

COPY . ./
RUN bundle install --jobs 20 --retry 5 --without staging

EXPOSE 3000

ENV EDITOR=vim

CMD sh ./docker/startup.sh
