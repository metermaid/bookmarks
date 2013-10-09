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
  end

  describe '#add_http' do
  	it "adds http if the url does not have it" do
  		expect { @bookmark.update_attributes(url: 'www.t.com') }.to change{@bookmark.url}.to 'http://www.t.com'
  	end
  	it "does not add http if the url already includes it" do
  		expect { @bookmark.update_attributes(url: 'http://www.t.com') }.to_not change{@bookmark.url}.to 'http://http://www.t.com'
  	end
  	it "does not add http if the url already includes https" do
  		expect { @bookmark.update_attributes(url: 'https://www.t.com') }.to_not change{@bookmark.url}.to 'http://https://www.t.com'
  	end
  end
end
