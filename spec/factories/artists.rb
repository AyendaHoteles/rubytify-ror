# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    name { Faker::Number.number(10)  }
    image { Faker::Number.number(10) }
    popularity { Faker::Number.number(5) }
    spotify_url { Faker::Number.number(10) }
    spotify_id { Faker::Number.number(10) }
  end
end
