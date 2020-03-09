FactoryBot.define do
  factory :artist do
    name { "MyString" }
    image { "MyString" }
    genres {[ "MyString" ]}
    popularity { 1 }
    spotify_url { "MyString" }
    spotify_id { "MyString" }
  end
end
