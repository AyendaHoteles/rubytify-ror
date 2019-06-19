FactoryBot.define do
  factory :album do
    name { Faker::Number.number(10)  }
    image { Faker::Number.number(10) }
    total_tracks { Faker::Number.number(5) }
    spotify_id { Faker::Number.number(5) }
    spotify_url { Faker::Number.number(5) }
    association :artist
  end
end