FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    image { "image_url" }
    genres { [Faker::Music.genre] }
    popularity { Random.rand(100).to_s }
    spotify_id { Faker::Alphanumeric.alphanumeric(number: 20) }
    spotify_url { "spotify_url" }
  end
end
