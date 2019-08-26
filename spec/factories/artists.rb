FactoryBot.define do
  factory :artist do
    name { Faker::Lorem.word }
  end
end