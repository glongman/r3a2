source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'mysql2'
gem "responders"
gem "devise"
gem "declarative_authorization"
gem "backpocket", :git => "git://github.com/jduff/backpocket.git"

group :development do
  gem "rails3-generators"
end

group :test do
  gem "factory_girl", :group => :test
  gem "factory_girl_rails", :group => :test
  gem "ZenTest", :group => :test
  gem "autotest-rails", :group => :test
end

group :development, :test do
  # To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
  gem 'ruby-debug'
  # gem 'ruby-debug19'
  gem 'shoulda'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
