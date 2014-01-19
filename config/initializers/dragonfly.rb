require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "725a2d740bb2405d8d803ecf5a332872473778663a6d7ee9c72e41c9398a3c7e"

  url_format "/media/:job/:name"

  datastore :s3,
    bucket_name: 'bookmarksrita',
    access_key_id: '***REMOVED***',
    secret_access_key: '***REMOVED***'

  # Override the .url method...
  define_url do |app, job, opts|
    thumb = Thumb.where(signature: job.signature)
    # If (fetch 'some_uid' then resize to '40x40') has been stored already, give the datastore's remote url ...
    if thumb.exists?
      app.datastore.url_for(thumb.first.uid)
    # ...otherwise give the local Dragonfly server url
    else
      app.server.url_for(job)
    end
  end

  # Before serving from the local Dragonfly server...
  before_serve do |job, env|
    # ...store the thumbnail in the datastore...
    uid = job.store

    # ...keep track of its uid so next time we can serve directly from the datastore
    Thumb.create!(uid: uid, signature: job.signature)
  end

#   datastore :file,
#   root_path: Rails.root.join('public/system/dragonfly', Rails.env),
#   server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
