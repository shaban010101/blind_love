source 'https://rubygems.org'

gem 'rails', '3.2.14'

gem 'pg', '~> 0.15.1'
gem "bcrypt-ruby", '~> 3.0.1' 
gem "paperclip", '~> 3.4.2'
gem "will_paginate", '~> 3.0.4'
gem "friendly_id", '~> 4.0.9'
gem 'stripe'
gem "thin"
gem "rb-fsevent"
gem 'devise'
gem "cancan"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '~> 2.3.2'
  gem 'uglifier', '>= 1.0.3'
  gem 'sprockets', '~> 2.0'
  gem 'foundation-rails'
end

group :test do
  gem 'rspec-rails', '2.13.2'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'capybara', '~> 2.1'
  gem 'launchy', '~> 2.3'
  gem 'guard-rspec', '~> 3.0.1'
  gem 'shoulda-matchers', '~> 2.1'
  gem  'webmock', '~>1.16'
  gem 'vcr', '2.8'
end

group :development do
  gem 'annotate', ">=2.5.0"
  gem  "debugger"
  gem "letter_opener"
end

group :test, :development do
  gem 'database_cleaner'
  gem 'rspec-rails', '2.13.2'
  gem 'guard-rspec', '~> 3.0.1'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'fuubar', '~> 1.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'rails_12factor', group: :production

gem 'jquery-rails', '~> 3.0.1'

ruby '2.0.0'
