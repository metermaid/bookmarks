require 'spec_helper'

describe UserHelper do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @bookmark = FactoryGirl.create(:bookmark)
  end

  describe '#user_name' do
  	context "does not have a user" do
      it "returns a blank username" do
  		  expect { user_name(@bookmark) == "Anonymous" }
      end
  	end
    before do
      @bookmark.update_attributes(user: @user)
    end
  	context "has a user" do
      it "returns the user's username" do
        expect { user_name(@bookmark) == @user.name }
      end
  	end
  end
end
