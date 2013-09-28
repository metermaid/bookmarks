FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    role 'user'
    provider 'twitter'
    uid 'something'
  end
end