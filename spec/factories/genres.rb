FactoryBot.define do
  factory :genre do
    name { Faker::Artist.name }
    #artist_genres { build_list(:artist_genre, 2) }

    #trait :with_artists do
    #  artists { build_list :artist, 3 }
    #end
  end
end