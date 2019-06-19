# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    name { Faker::Number.number(5) }
    spotify_url { Faker::Number.number(5) }
    spotify_id { Faker::Number.number(5) }
    preview_url { Faker::Number.number(5) }
    duration_ms { Faker::Number.number(5) }
    explicit { Faker::Boolean }
    association :album
  end
end