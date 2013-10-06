require 'spec_helper'

describe Comment do

  before(:all) do
    @bookmark = FactoryGirl.create(:bookmark)
    @comment = FactoryGirl.create(:comment)
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:bookmark) }
  end
  describe 'validations' do
    it { should validate_presence_of :body }
  end

  describe '#user_name' do
  	context "does not have a user" do
      it "returns a blank username" do
  		  expect { @comment.user_name.should == "Anonymous" }
      end
  	end
    before do
      @user = FactoryGirl.create(:user)
      @comment.update_attributes(user: @user)
    end
  	context "has a user" do
      it "returns the user's username" do
        expect { @comment.user_name.should == @user.name }
      end
  	end
  end
end
