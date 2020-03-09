FactoryBot.define do
  factory :album do
    artist
    name { "MyString" }
    image { "MyString" }
    spotify_url { "MyString" }
    total_tracks { 1 }
    spotify_id { "MyString" }
  end
end
