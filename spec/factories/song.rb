FactoryBot.define do
  factory :song do
    name { Faker::Music::UmphreysMcgee.song }
    spotify_url { Faker::Alphanumeric.alphanumeric(number: 20) }
    preview_url { "preview_url" }
    duration_ms { "duration_ms_url" } 
    explicit { false }
    spotify_id { Faker::Alphanumeric.alphanumeric(number: 20) }
  end
end
