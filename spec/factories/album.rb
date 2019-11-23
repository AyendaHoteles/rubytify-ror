FactoryBot.define do
  factory :album do
    name { Faker::Music.album }
    image { "image_url" }
    spotify_url { "spotify_url" }
    total_tracks { Random.rand(100).to_s }
    spotify_id { Faker::Alphanumeric.alphanumeric(number: 20) }
  end
end