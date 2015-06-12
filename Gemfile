source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2'
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
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# cocoon for easy nested forms
gem 'cocoon'
# FactoryGirl to replace fixtures for test data
gem "factory_girl_rails", "~> 4.0"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Puma as the app server
gem 'puma'

# Use Kaminari for pagination
gem 'kaminari'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Paperclip for handling uploaded images
gem "paperclip", "~> 4.2"

# multiple table inheritance
gem 'active_record-acts_as'

gem "money-rails"

# ancestry for hierarchical relationships
gem 'ancestry'

# Automatic eager loading
gem 'goldiloader'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rails_layout'

  # detects N+1 queries while browsing in development
  gem "bullet"
end

group :test do
  gem 'simplecov', :require => false
end

