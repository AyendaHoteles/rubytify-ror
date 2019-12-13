FactoryBot.define do
  factory :song do
    association :album, factory: :album
    name { Faker::BossaNova.song }
    preview_url { Faker::Internet.url }
    spotify_url { Faker::Internet.url }
    duration_ms { rand(40_000..60_000) }
    explicit { Faker::Boolean.boolean }
    spotify_id { SecureRandom.uuid }
  end
end
