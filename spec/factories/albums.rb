# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    name { Faker::Music.unique.album }
    image { Faker::Avatar.image }
    total_tracks { rand(1..20) }
    spotify_url { Faker::Internet.url('api.spotify.com') }
    spotify_id { SecureRandom.uuid }
    association :artist, factory: :artist
  end
end
