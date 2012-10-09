# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Gonzales.configure do |config|
  config.factory_module = Rails.root.join('test', 'dummy', 'tmp', 'speedy.yml')
  config.factory_cache =  Rails.root.join('test', 'dummy', 'test', 'gonzales.rb')
end
