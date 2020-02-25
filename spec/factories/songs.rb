# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    name { Faker::DcComics.unique.title }
    preview_url { Faker::Internet.url('api.spotify.com') }
    duration_ms { rand(237_625..637_625) }
    explicit { [true, false].sample }
    spotify_url { Faker::Internet.url('api.spotify.com') }
    spotify_id { SecureRandom.uuid }
    association :album, factory: :album
  end
end
