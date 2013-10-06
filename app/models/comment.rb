class Comment
  include Mongoid::Document
	include Mongoid::Timestamps

  field :body, type: String
  belongs_to :bookmark
  belongs_to :user

  validates_presence_of :body

  def user_name
  	if user.present? and user.name.present?
  		user.name
  	else
  		"Anonymous"
  	end
  end
end
