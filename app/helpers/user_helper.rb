module UserHelper
	def user_link(user)
		if user.present?
			link_to_unless_current user_name(user), user
		else
			"Anonymous"
		end
	end

	def user_name(user)
		if user.present? and user.name.present?
			user.name
		else
			"Anonymous"
		end
	end
end
