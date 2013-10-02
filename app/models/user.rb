class User
	include Mongoid::Document

	#rolify :before_add => :before_add_method

	field :provider, type: String
	field :uid, type: String
	field :name, type: String
	field :email, type: String

	has_many :bookmarks

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
