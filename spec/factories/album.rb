FactoryBot.define do
  factory :album do
    name { Faker::Lorem.word }
    image { Faker::Lorem.word }
    spotify_url { Faker::Lorem.word }
    total_tracks 16
    spotify_id { Faker::Lorem.word }
    artist_id nil
  end
end
