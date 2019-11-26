FactoryBot.define do
  factory :song do
    name            { Faker::Music::Phish.song }
    spotify_url     { 'spotify_url song' }
    duration_ms     { 'duration_ms song' }
    explicit        { 'explicit song' }
    spotify_id      { 'spotify_id song' }
    album
  end
end
