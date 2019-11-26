FactoryBot.define do
  factory :album do
    name            { Faker::Music.album }
    image           { 'image url album' }
    spotify_url     { 'spotify_url album' }
    total_tracks    { 'total_tracks album' }
    spotify_id      { 'spotify_id album' }
    artist

    trait :with_song do
      after(:create) do |album|
        create :song, album: album
      end
    end
  end
end
