FactoryBot.define do
  factory :album do
    name { Faker::Artist.name }
    image { 'image_url' }
    total_tracks { Faker::Number.number(2) }
    spotify_url { 'spotify_url' }
    spotify_id { 'spotify_id' }
    before(:create) do |album|
      album.artist = create(:artist)
    end
    songs { build_list(:song, 2) }
  end
end