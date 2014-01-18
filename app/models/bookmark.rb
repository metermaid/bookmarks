require 'uri'
require 'pismo'

class Bookmark
  include Mongoid::Document
  include Mongoid::Taggable
	include Mongoid::Timestamps
  extend Dragonfly::Model

  field :title, type: String
  field :url, type: String
  field :description, type: String
  field :full_text, type: String
  field :favourite, type: Mongoid::Boolean

  field :thumbnail_uid, type: String
  field :thumbnail_name, type: String

  dragonfly_accessor :thumbnail

  belongs_to :user
  has_many :comments, :dependent => :destroy

  validates_presence_of :url
  validates :url, :format => URI::regexp(%w(http https))
  after_validation :scrape_info

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
    as_json only: [:title, :description, :tags, :full_text]
  end

  private

  def scrape_info
    if title.blank? || description.blank? || tags.blank?
      doc = Pismo::Document.new(url, :all_images => true)
      self.title = doc.title
      self.description = doc.description || doc.lede
      self.full_text = doc.body
      self.tags = doc.keywords.map {|item| item.first }.join(",")

      self.thumbnail_url = doc.images.first if doc.images.present?
    end
  end

end
