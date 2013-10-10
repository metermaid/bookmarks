source 'https://rubygems.org'

gem 'rails', "~> 4.0.0"
gem 'journey', :git => 'git://github.com/rails/journey.git' 

# server
gem 'thin'
gem "rails_12factor", :group => :production # rails dev on heroku
gem "heroku"

# db
gem 'mongoid', github: 'mongoid/mongoid'

# content / plugin-y
gem 'searchkick' # searching
gem 'mongoid_taggable' # tags
gem 'pismo' # scraping for links
# gem 'link_thumbnailer' # scraping for thumbs
gem 'high_voltage' # static pages
# gem "analytics-ruby"
gem 'kaminari' # pagination

# uploading
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid' # image uploads
gem 'mongoid-grid_fs', github: 'ahoward/mongoid-grid_fs' # for carrierwave?


# asset-y
#gem 'sass-rails', github: 'rails/sass-rails'
gem 'coffee-rails', github: 'rails/coffee-rails'
gem 'uglifier', '>= 1.0.3'
gem "therubyracer"
gem "less-rails" # Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "neat" # Grid & Useful SASS mixins
gem 'jquery-rails'
# gem "simple_form", ">= 2.1.0"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "font-awesome-rails"
gem 'turbolinks'

#test, etc.
gem "rspec-rails", ">= 2.12.2", :group => [:development, :test]
gem "factory_girl_rails", ">= 4.2.0", :group => [:development, :test]
gem "database_cleaner", ">= 0.9.1", :group => :test
gem 'mongoid-rspec', :group => :test
gem "email_spec", ">= 1.4.0", :group => :test
gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false, git: 'https://github.com/cucumber/cucumber-rails.git'
gem "capybara", ">= 2.0.2", :group => :test
gem "launchy", ">= 2.1.2", :group => :test

# auth
gem "cancan", ">= 1.6.9"
gem "omniauth"
gem "omniauth-twitter"

#conf
gem "figaro", ">= 0.5.3"
gem "better_errors", ">= 0.3.2", :group => :development
gem "binding_of_caller", ">= 0.6.8", :group => :development