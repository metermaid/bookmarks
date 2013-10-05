FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    provider 'twitter'
    uid '123'

    factory :admin do
      role 'admin'
      uid '123456'
    end
  end
end