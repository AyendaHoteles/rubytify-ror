FactoryBot.define do
  factory :song do
    name { Faker::Name.name  }
    spotify_url { "MyString" }
    preview_url { "MyString" }
    duration_ms { "MyString" }
    explicit { "MyString" }
    spotify_id { "MyString" }
    album
  end
end
