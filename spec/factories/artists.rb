FactoryBot.define do
  factory :artist do
    name { Faker::Artist.name }
    image { 'image_url' }
    popularity { Faker::Number.number(2) }
    spotify_url { 'spotify_url' }
    spotify_id { 'spotify_id' }
    albums { build_list(:album, 2) }
    #artist_genres { build_list(:artist_genre, 2) }

    #trait :with_genres do
    #  genres { build_list :genre, 3 }
    #end
  end
end