FactoryBot.define do
  factory :artist do
    name { 'Artist' }
    popularity { 50 }
    spotify_id { SecureRandom.hex(10) }
    spotify_url { SecureRandom.hex(10) }

    after :create do |artist|
      genre_attr = attributes_for(:genre)
      artist.genres.find_or_create_by(genre_attr)
    end
  end

  factory :album do
    name { 'Awesome Album' }
    spotify_id { SecureRandom.hex(10) }
    spotify_url { SecureRandom.hex(10) }
    total_tracks { 10 }
    artist { create(:artist) }
  end

  factory :song do
    name { 'Song' }
    spotify_id { SecureRandom.hex(10) }
    spotify_url { SecureRandom.hex(10) }
    preview_url { SecureRandom.hex(10) }
    duration_ms { 3029 }
    album { create(:album) }
    explicit { false }
  end

  factory :genre do
    name { 'popular genre' }
  end
end
