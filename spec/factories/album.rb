FactoryBot.define do
  factory :album do
    association :artist, factory: :artist
    name { Faker::Music.album }
    image { Faker::Internet.url }
    spotify_url { Faker::Internet.url }
    total_tracks { rand(7..12) }
    spotify_id { SecureRandom.uuid }
  end
end
