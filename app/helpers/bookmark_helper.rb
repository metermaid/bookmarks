module BookmarkHelper
	def comment_link(bookmark)
		if bookmark.comments.empty?
			link_to_unless_current "No Comments", bookmark
		else
			link_to_unless_current pluralize(bookmark.comments.count, "Comment"), bookmark
		end
	end
end
