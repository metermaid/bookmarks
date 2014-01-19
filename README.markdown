#Rails-based anti-social Bookmarking

This is somewhat of a reddit/delicious clone, but philosophically different at its core: only administrators can post bookmarks, but anybody with an account can comment. It's a bit anti-social that way, but the idea is to have strong editorial rather than listen to the masses.

##Setup
1. You'll need to install MongoDB. On OSX, if you have homebrew you can simply type in the command:
brew install mongodb
2. We're using Omniauth (other service providers) as our only login option-- there's one less password to memorize. You'll need to setup an app in Twitter/Facebook/Linkedin/Github/etc. I recommend a Twitter app, as it's widely used and has less of a 'privacy-invasive' feel than Facebook. You can set up a Twitter app here: https://dev.twitter.com/apps/new
3. You need ruby, rails, and bundler installed. You can use RVM, or homebrew if this'll be your only app:
`brew install ruby`
`brew install rails`
`brew install bundler`
4. Clone this app.
5. If you're using the default port for MongoDB, mongoid.yml should be correct. Otherwise, change the settings as necessary.
6. Rename omniauth.rb.example to omniauth.rb, and change the key and secret from the app created in step 2.
7. Run `bundle install`.
8. The app should work now, just `rails s` to startup.

##Heroku Deployment Instructions
Because I've been deploying on Heroku myself, this should be reasonably straight-forward.

1. Sign up for a Heroku account if you haven't already.
2. Install the Heroku gem or the Heroku CLI: http://devcenter.heroku.com/articles/heroku-command
3. Clone this app `git clone git@github.com:metermaid/bookmarks.git bookmarks`
4. Create the app on Heroku (replace myapp with something unique): `heroku create myapp`
5. You'll need to add both MongoDB and Elasticsearch to your app. If you use bonsai and mongolab, no further configuration should be necessary. To do so, run: `heroku addons:add mongolab` and `heroku addons:add bonsai`.
6. We're using Omniauth (other service providers) as our only login option-- there's one less password to memorize. You'll need to setup an app in Twitter/Facebook/Linkedin/Github/etc. I recommend a Twitter app, as it's widely used and has less of a 'privacy-invasive' feel than Facebook. You can set up a Twitter app here: https://dev.twitter.com/apps/new
7. Rename omniauth.rb.example to omniauth.rb, and change the key and secret from the app created in the previous step.
8. Sign up for Amazon S3: https://devcenter.heroku.com/articles/s3#s3-setup
9. Comment out the file datastore of `config/initializers/dragonfly.rb` and uncomment the S3 datastore. Fill this in with your credentials.
10. Push your application to Heroku: `git push heroku master`
11. The app should work now, open it with `heroku open`

##Somewhat Neat Features
- Tagging
- Search
- Comments
- Admin Favourites
- Daily digest RSS feed
- Bookmarklet
- Thumbnails

##Coming Soon
- Daily digest mailings