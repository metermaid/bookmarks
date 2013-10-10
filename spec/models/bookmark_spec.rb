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
    it "rejects URLs missing the URI" do
      expect { @bookmark.update_attributes!(url: 'www.t.com') }.to raise_error
    end
    it "validates correct URLs" do
      expect { @bookmark.update_attributes!(url: 'http://www.t.com') }.not_to raise_error
    end
  end

  describe '#scrape_info' do
    context "Bookmark doesn't have any info except url" do
      it "adds a title upon creation" do
        expect(@bookmark.title).to eq('Clients using our online testing and certification software')
      end
      it "adds a description upon creation" do
        expect(@bookmark.description).to eq('Test.com provides a complete software solution for creating online tests and managing enterprise and specialist certification programs, in up to 22 languages.')
      end
      it "adds tags upon creation" do
        expect(@bookmark.tags).to eq('software,testing,clients,certification,test.com,tests,solution,22,languages,training,patent,hosted,network,test.com\'s,pledge,programs,proven')
      end
    end
  end
end
