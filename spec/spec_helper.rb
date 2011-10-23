ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"
require "database_cleaner"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  DatabaseCleaner.orm = "mongoid" 
  DatabaseCleaner.strategy = :truncation
  
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
