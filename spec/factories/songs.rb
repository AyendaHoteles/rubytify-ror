FactoryBot.define do
  factory :song do
    album
    name { "MyString" }
    spotify_url { "MyString" }
    preview_url { "MyString" }
    duration_ms { 1 }
    explicit { false }
    spotify_id { "MyString" }
  end
end
