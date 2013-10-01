FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    provider 'twitter'
    uid 'something'

    factory :admin do
      #  after(:create) {|user| user.add_role(:admin)}
    end
  end
end