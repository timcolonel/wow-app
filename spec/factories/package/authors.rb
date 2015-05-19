FactoryGirl.define do
  factory :package_author, :class => Package::Author do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end