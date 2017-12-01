source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.5'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# - causes issues with document ready events
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# cocoon for easy nested forms
gem 'cocoon'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Puma as the app server
gem 'puma'

# Use Kaminari for pagination
gem 'kaminari'

# Paperclip for handling uploaded images
gem "paperclip", "~> 5.0.0"

gem "money-rails", "~> 1.9"

# ancestry for hierarchical relationships
gem 'ancestry'

# Automatic eager loading
gem 'goldiloader'

# Use prawn to generate PDFs
gem 'prawn-rails'

gem 'rails4-autocomplete'
gem 'jquery-ui-rails'

gem 'rails-erd', group: :development

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # detects N+1 queries while browsing in development
  gem "bullet"
end

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rails_layout'
end

group :test do
  # FactoryBot to replace fixtures for test data
  gem "factory_bot_rails"

  gem 'simplecov', :require => false
end

