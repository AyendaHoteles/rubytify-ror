FactoryBot.define do
  factory :album do
    name { Faker::Lorem.word }
  end
end