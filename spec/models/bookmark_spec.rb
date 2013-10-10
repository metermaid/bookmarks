require 'spec_helper'

describe Bookmark do
  before(:all) do
    @bookmark = FactoryGirl.create(:bookmark)
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
  describe 'validations' do
    it { should validate_presence_of :url }
    it "rejects URLs missing protocols" do
      expect { @bookmark.update_attributes!(url: 'www.t.com') }.to raise_error
    end
    it "validates correct URLs" do
      expect { @bookmark.update_attributes!(url: 'http://www.t.com') }.not_to raise_error
    end
  end
end
