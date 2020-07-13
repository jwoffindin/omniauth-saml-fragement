source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '2.5.3'

gem "rails", "~> 6.0.0"
gem "view_component"

gem "puma", "~> 3.12"
gem "sass-rails", "~> 5"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "pg"
gem "image_processing", "~> 1.2"
gem "bootsnap", ">= 1.4.2", require: false

gem "closure_tree" # categories are stored as a tree structure
gem "foreman"
gem "haml-rails", "~> 2.0"
gem "chronic_duration" # Parsing duration inputs for service changes
gem "hublot"
gem "ros-apartment", require: "apartment" # see https://github.com/rails-on-services/apartment
gem "devise"

gem "bootstrap_form"
gem "premailer-rails"

gem "omniauth"
gem "omniauth-rails_csrf_protection"
gem "omniauth-saml"

gem "friendly_id"
gem "sidekiq"
gem "sidekiq-cron"
gem "name_of_person"
gem "gravatar_image_tag", github: "mdeering/gravatar_image_tag"
gem "mini_magick", "~> 4.9", ">= 4.9.2"
gem "local_time"

gem "simon_says"
gem "cocoon"
gem "store_model"
gem "pg_search"
gem "stateful_enum", github: "unasuke/stateful_enum" # See https://github.com/amatsuda/stateful_enum/pull/34
gem "lockup"

gem "rails-healthcheck"

gem "rails_semantic_logger"
gem "elasticsearch"
gem "awesome_print"

gem "slack-ruby-client"

# Ideally dev/test, but for now we're also loading test data in prod
gem "faker"
gem "literate_randomizer"

group :development, :test do
  gem "chronic"
  gem "byebug"
  gem "spring-commands-rspec"
  gem "rspec-rails"
  gem "ripper-tags"
end

group :development do
  gem "guard-rspec"
  gem "web-console", ">= 3.3.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rufo"
  gem "solargraph"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "kramdown"
end

group :development, :qa do
  gem "meta_request"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "capybara-email"
  gem "webdrivers"
  gem "selenium-webdriver"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem "rails-controller-testing"
  gem "rspec_junit_formatter"
end

group :development, :test, :qa do
  gem "pry"
end
