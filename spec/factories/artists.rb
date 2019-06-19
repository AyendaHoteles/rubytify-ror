# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    name { Faker::Name }
    image { Faker::Name }
    popularity { Faker::Number.number(5) }
    spotify_url { Faker::String.random }
    spotify_id { Faker::String.random }
  end
end
