class Bookmark
  include Mongoid::Document
  include Mongoid::Taggable
	include Mongoid::Timestamps

  field :title, type: String
  field :url, type: String
  field :description, type: String
  belongs_to :user

  before_save :add_http

  def user_name
  	if user.present?
  		user.name
  	else
  		"Anonymous"
  	end
  end

  private

  def add_http
  	unless url.start_with?('http') or url.start_with('https')
  		url = 'http://' + url
  	end
  end

end
