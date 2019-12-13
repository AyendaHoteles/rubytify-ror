FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    image { Faker::Internet.url }
    genres { [Faker::Music.genre] }
    popularity { rand(10..100) }
    spotify_url { Faker::Internet.url }
    spotify_id { SecureRandom.uuid }
  end
end
