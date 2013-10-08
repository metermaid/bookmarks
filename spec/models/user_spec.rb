require 'spec_helper'

describe User do
  before(:all) do
    @user = FactoryGirl.create(:user)
  end

  describe 'associations' do
    it { should have_many(:bookmarks) }
  end
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
    it { should validate_uniqueness_of :uid }
  end

  describe '#has_role?' do
  	context "a user needs its role checked" do
      it "returns true and behaves as a user when they have no role" do
  		  expect { @user.has_role?("user").should be_true }
      end
      it "returns false and behaves as a user when they have no role" do
        expect { @user.has_role?("admin").should false }
      end
      before do
        @user.role = "user"
      end
      it "returns true when it's checked to be a user" do
        expect { @user.has_role?("user").should be_true }
      end
      it "returns false when it's checked to be an admin" do
        expect { @user.has_role?("admin").should be_false }
      end
  	end
    before do
      @admin = FactoryGirl.create(:admin)
    end
    context "an admin needs its role checked" do
      it "returns false when it's checked to be a user" do
        expect { @admin.has_role?("user").should be_false }
      end
      it "returns false when it's checked to be an admin" do
        expect { @admin.has_role?("admin").should be_true }
      end
  	end
  end

  describe '.create_with_omniauth' do
    context "no current account" do
      before(:each) do
        @auth = OmniAuth.config.mock_auth[:twitter]
      end
      it "should create the user" do
        expect { User.create_with_omniauth(@auth) }.to change(User, :count).by(1)
      end
    end
  end
end