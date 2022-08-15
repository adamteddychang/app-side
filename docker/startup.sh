rm -rf /app/tmp

bundle config set without 'staging'
bundle install --jobs 20 --retry 5

bundle exec rails server -b "0.0.0.0"
