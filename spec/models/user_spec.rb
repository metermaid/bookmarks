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
  	it "checks a user" do
  		expect { @user.has_role?("user").should be_true }
  		expect { @user.has_role?("admin").should be_false }
  	end
    before do
      @admin = FactoryGirl.create(:admin)
    end
  	it "checks an admin" do
  		expect { @admin.has_role?("user").should be_false }
  		expect { @admin.has_role?("admin").should be_true }
  	end
  end

  describe '.find_or_create' do
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