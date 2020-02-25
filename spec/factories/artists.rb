# frozen_string_literal: true

FactoryBot.define do
  # Enums -------------------------------------
  genres = [
    :alternative_metal,
    :groove_metal,
    :hard_rock,
    :metal,
    :nu_metal,
    :old_school_thrash,
    :rock,
    :wrestling
  ]

  factory :artist do
    name { Faker::Music.unique.band }
    image { Faker::Avatar.image }
    genres { genres }
    popularity { rand(1..50) }
    spotify_url { Faker::Internet.url('api.spotify.com') }
    spotify_id { SecureRandom.uuid }
  end
end
