FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    image { "MyString" }
    genres { [Faker::Music.genre] }
    popularity { rand(1..1000) }
    spotify_url { "MyString" }
    spotify_id { "MyString" }
  end
end
