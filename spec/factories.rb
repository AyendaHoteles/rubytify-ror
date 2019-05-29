FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    image { Faker::LeagueOfLegends.name }
    genres { Faker::Name.name }
    spotify_url { Faker::Name.name }
    spotify_id { Faker::Name.name }
    popularity {Faker::Number.number(2)}
  end


  factory :album do
    association :artist, :factory => :artist
    name { Faker::Name.name }
    image { Faker::LeagueOfLegends.champion }
    spotify_url { Faker::Name.name }
    spotify_id { Faker::Name.name }
    total_tracks {Faker::Number.number(2)}
  end



  factory :song do
    association :album, :factory => :album

    name { Faker::Name.name }
    explicit { true }
    preview_url { Faker::Name.name }
    spotify_url { Faker::Name.name }
    spotify_id { Faker::Name.name }
    duration_ms {Faker::Number.number(7)}
  end
end