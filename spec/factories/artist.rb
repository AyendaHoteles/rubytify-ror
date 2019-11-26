FactoryBot.define do
  factory :artist do
    name             { Faker::Artist.name }
    image            { 'image artist' }
    genres           { ['post-grunge', 'rock', 'piano'] }
    popularity       { 'popularity artist' }
    spotify_url      { 'spotify_url artist' }
    spotify_id       { 'spotify_id artist' }

    trait :with_album do
      after(:create) do |artist|
        create :album, artist: artist
      end
    end
  end
end
