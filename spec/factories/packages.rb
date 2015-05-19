FactoryGirl.define do
  factory :package do
    sequence(:name) { |n| "#{Faker::App.name}#{n}" }
    homepage { Faker::Internet.url }
    short_description { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    association :user

    after(:create) do |package|
      package.authors << create(:package_author)
    end

    after(:create) do |package|
      package.tags << create(:tag)
    end
  end
end