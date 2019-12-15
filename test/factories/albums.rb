FactoryBot.define do
  factory :album do
    name { Faker::Name.name }
    image { "MyString" }
    spotify_url { "MyString" }
    total_tracks { 1 }
    spotify_id { "MyString" }
    artist
  end
end
