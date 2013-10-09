require 'spec_helper'

describe BookmarkHelper do

  before (:each) do
    @bookmark = FactoryGirl.create(:bookmark)
    @comment = FactoryGirl.create(:comment)
    self.stub(:current_page?) { true }
  end

  describe "#comment_link" do
  	context "does not have any comments" do
      it "returns a link as 'No Comments'" do
  		  expect { comment_link(@bookmark) == link_to("No Comments", @bookmark) }
      end
  	end
    before do
      @comment.update_attributes(bookmark: @bookmark)
    end
  	context "has a comment" do
      it "returns a link as '1 Comment'" do
  		  expect { comment_link(@bookmark) == link_to("1 Comment", @bookmark) }
      end
  	end
	end

end
