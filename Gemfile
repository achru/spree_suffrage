source 'http://rubygems.org'

gem 'spree', github: 'spree/spree'

# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', :git => "git://github.com/spree/spree_auth_devise"

gemspec

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
end

group :test do
  gem 'rspec-rails', '~> 2.12.0'
  gem 'factory_girl_rails', '~> 4.2.1'

  gem 'ffaker'
#  gem 'shoulda-matchers', '~> 1.0.0'
#  gem 'capybara', '1.1.3'
  gem 'selenium-webdriver', '2.30.0'
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'
  gem 'pry'
 # gem 'webmock', '1.8.11'
#  gem 'email_spec', '1.4.0'
end

group :development do
  gem 'fuubar'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
end

