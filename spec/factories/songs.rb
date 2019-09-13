FactoryBot.define do
  factory :song do
    name { Faker::Lorem.word }
    spotify_url { Faker::Lorem.word }
    preview_url { Faker::Lorem.word }
    duration_ms { 60 }
    explicit { true }
    spotify_id { Faker::Lorem.word }
    album_id nil
    gender_id nil
  end
end
