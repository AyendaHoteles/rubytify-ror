FactoryBot.define do
  factory :song do
    name { "MyString" }
    spotify_url { "MyString" }
    spotify_id { "MyString" }
    preview_url { "MyString" }
    duration_ms { "" }
    explicit { false }
    album { nil }
  end
end
