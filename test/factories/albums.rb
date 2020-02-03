FactoryBot.define do
  factory :album do
    name { "MyString" }
    spotify_id { "string" }
    spotify_url { "string" }
    artist
  end
end
