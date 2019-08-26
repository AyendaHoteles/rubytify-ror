FactoryBot.define do
  factory :song do
    name { Faker::Lorem.word }
  end
end