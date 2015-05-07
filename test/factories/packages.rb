FactoryGirl.define do
  factory :package do
    name { Faker::App.name }
    homepage { Faker::Internet.url }
    short_description { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    association :user
  end
end