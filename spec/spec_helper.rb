# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include SessionSpecHelper, :type => :controller

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  
  # database cleanin'
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner[:mongoid].start
  end
  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end

  # test authentication
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:twitter] = {
    'provider' => 'twitter',
    'uid' => '1234567',
    'info' => { 'name' => 'dork face', 'email' => 'dork@face.com' },
    'credentials' => { 'token' => 'twitter token', 'secret' => 'jj' }
  }
end
