require 'uri'

class Bookmark
  include Mongoid::Document
  include Mongoid::Taggable
	include Mongoid::Timestamps

  field :title, type: String
  field :url, type: String
  field :description, type: String
  field :favourite, type: Mongoid::Boolean

  belongs_to :user
  has_many :comments, :dependent => :destroy

  validates_presence_of :url
  validates :url, :format => URI::regexp(%w(http https))


	scope :favourites, where(favourite: true)
	scope :by_date, (lambda do |date| 
	  dt = DateTime.strptime(date, "%Y-%m-%d")
	  bod = dt.beginning_of_day
	  eod = dt.end_of_day
	  where(:created_at.gte => bod, :created_at.lte => eod)
	end)


  paginates_per 7
  searchkick

  def user_name
  	if user.present? and user.name.present?
  		user.name
  	else
  		"Anonymous"
  	end
  end

  def search_data
    as_json only: [:title, :descrption, :tags]
  end

end
