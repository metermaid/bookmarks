# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookmark do
    title "MyString"
    description "MyText"
    url "http://www.test.com"
  end
end
