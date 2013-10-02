class Bookmark
  include Mongoid::Document
  include Mongoid::Taggable

  field :title, type: String
  field :url, type: String
  field :description, type: String
  belongs_to :user
end
