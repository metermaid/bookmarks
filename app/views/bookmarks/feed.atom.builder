atom_feed :language => 'en-US' do |feed|
  feed.title @titles
  feed.updated @updated
  @days.sort.each do |day, bookmarks|
    description = ""
    bookmarks.each do |bookmark|
        description << "<h3>#{link_to bookmark.title, bookmark.url}</h3><div>#{bookmark.description}</div>"
    end

    feed.entry( bookmarks.first, url: bookmarks_url(date: day.strftime("%Y-%m-%d")) ) do |entry| # first bookmark is a hack
      entry.url bookmarks_url(date: day)
      entry.title "Links for #{day.strftime("%B %e, %Y")}"
      entry.author "Bookmarks"
      entry.content description, :type => 'html'

      entry.updated(day.beginning_of_day.strftime("%Y-%m-%dT%H:%M:%SZ"))  # the strftime is needed to work with Google Reader.

    end
  end
end