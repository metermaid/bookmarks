require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @bookmark = FactoryGirl.create(:bookmark, user: @user)
  end

  describe "GET 'show'" do
    it "assigns the user's posts as @items" do
      get 'show', id: @user.id
      assigns(:items).should eq([@bookmark])
    end

    it "returns http success" do
      get 'show', id: @user.id
      response.should be_success
    end
  end

end
