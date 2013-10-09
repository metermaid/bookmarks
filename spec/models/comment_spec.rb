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
end
