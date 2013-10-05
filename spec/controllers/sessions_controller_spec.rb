require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "redirects to 'twitter'" do
      get 'new'
      response.should redirect_to "/auth/twitter"
    end
  end

  describe "POST 'create'" do
    context "user already exists" do
      before(:each) do
        @user = FactoryGirl.create(:user, uid: '1234567')
        session[:user_id] = @user.id
        oauth_credentials(:twitter)
      end
      
      it "does not create a new user" do
        expect { post 'create' }.not_to change(User, :count)
      end

      it "redirects to the root path on success" do
        get 'create'
        response.should redirect_to root_url
      end
    end
    context "user does not exist" do
      before(:each) do
        oauth_credentials(:twitter)
      end
      
      it "creates a new user" do
        expect { post 'create' }.to change(User, :count).by(1)
      end

      it "redirects to the root path on success" do
        post 'create'
        response.should redirect_to root_url
      end
    end
  end

  describe "GET 'failure'" do
    it "redirects to the root with an error message" do
      get 'failure', { :message => "a real error would actually have an error message" }

      flash[:notice].should_not be_nil
      response.should redirect_to root_url
    end
  end

  describe "DELETE 'destroy'" do
    it "deletes the session" do
      delete 'destroy'

      session[:user_id].should be_nil
    end
    it "redirects to the root with an error message" do
      delete 'destroy'

      flash[:notice].should_not be_nil
      response.should redirect_to root_url
    end
  end

end