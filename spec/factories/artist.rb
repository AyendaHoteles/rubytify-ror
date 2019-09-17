FactoryBot.define do
  factory :artist do
    name { Faker::Lorem.word }
    image { Faker::Lorem.word }
    popularity 100
    spotify_url { Faker::Lorem.word }
    spotify_id { Faker::Lorem.word }
  end
end
