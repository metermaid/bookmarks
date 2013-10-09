#Rails-based anti-social Bookmarking

This is somewhat of a reddit/delicious clone, but philosophically different at its core: only administrators can post bookmarks, but anybody with an account can comment. It's a bit anti-social that way, but the idea is to have strong editorial rather than listen to the masses.

##Setup
1. You'll need to install MongoDB. On OSX, if you have homebrew you can simply type in the command:
brew install mongodb
2. We're using Omniauth (other service providers) as our only login option-- there's one less password to memorize. You'll need to setup an app in Twitter/Facebook/Linkedin/Github/etc. I recommend a Twitter app, as it's widely used and has less of a 'privacy-invasive' feel than Facebook. You can set up a Twitter app here: https://dev.twitter.com/apps/new
3. You need ruby, rails, and bundler installed. You can use RVM, or homebrew if this'll be your only app:
brew install ruby
brew install rails
brew install bundler
4. Clone this app.
5. If you're using the default port for MongoDB, mongoid.yml should be correct. Otherwise, change the settings as necessary.
6. Rename omniauth.rb.example to omniauth.rb, and change the key and secret from the app created in step 2.
7. Run bundle install .
7. The app should work now, just "rails s" to startup.

##Heroku Setup Instructions
Coming soon? 

##Somewhat Neat Features
- Tagging
- Search
- Comments
- Favourites (These are more like 'highlights')
- Daily digest RSS feed

##Coming Soon
- Scraping for thumbnails, etc.
- Tag page
- Daily digest mailings