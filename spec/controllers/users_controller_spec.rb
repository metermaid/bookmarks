require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @user.id
      response.should be_success
    end
  end

end
