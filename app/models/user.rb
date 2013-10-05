class User
	include Mongoid::Document

	field :provider, type: String
	field :uid, type: String
	field :name, type: String
	field :email, type: String
	field :role, type: String

	has_many :bookmarks

  validates_presence_of :name
  validates_presence_of :uid
  validates_presence_of :provider
  validates_uniqueness_of :uid

	def has_role?(new_role)
		role.present? and role == new_role
	end

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth['provider']
			user.uid = auth['uid']
			if auth['info']
				user.name = auth['info']['name'] || ""
				user.email = auth['info']['email'] || ""
			end
		end
	end
end
