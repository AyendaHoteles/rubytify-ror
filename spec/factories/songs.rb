FactoryBot.define do
  factory :song do
    name { Faker::Artist.name }
    preview_url { 'preview_url' }
    duration_ms { Faker::Number.number(6) }
    explicit  { Faker::Boolean.boolean }
    spotify_url { 'spotify_url' }
    spotify_id { 'spotify_id' }
  end
end