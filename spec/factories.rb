FactoryBot.define do
  genres = ["rock", "pop", "latin", "salsa"]
  factory :random_artist, class: Artist do
    name { Faker::Lorem.name }
    image { Faker::Lorem.sentence }
    genres { genres.sample }
    spotify_url  { Faker::Lorem.sentence }
    popularity { Faker::Number.between(1, 100 ) }
  end
end
FactoryBot.define do
  factory :random_album, class: Album do
    artist
    name { Faker::Lorem.name }
    image { Faker::Lorem.sentence }
    spotify_url { Faker::Lorem.sentence }
    total_tracks { Faker::Number.between(1, 40 ) }
  end
end

FactoryBot.define do
  factory :artist do
    name { Faker::Lorem.name }
    image { Faker::Lorem.sentence }
    genres { genres.sample }
    spotify_url  { Faker::Lorem.sentence }
    popularity { Faker::Number.between(1, 100 ) }
  end

  factory :album do
    association :artist, :factory => :artist
    name { Faker::Lorem.name }
    image { Faker::Lorem.sentence }
    spotify_url { Faker::Lorem.sentence }
    total_tracks { Faker::Number.between(1, 40 ) }
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
