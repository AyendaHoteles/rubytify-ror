FactoryBot.define do
  factory :album do
    name { "MyString" }
    image { "MyString" }
    spotify_url { "MyString" }
    spotify_id { "MyString" }
    total_tracks { 1 }
    artist { nil }
  end
end
