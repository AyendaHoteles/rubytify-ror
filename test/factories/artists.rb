FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    image { "xxxxxx" }
    genres { "test" }
    popularity { 1 }
    spotify_url { "/xxxx/xxxxx" }
    spotify_id { "3" }
  end
end
