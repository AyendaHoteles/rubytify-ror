FactoryBot.define do
  factory :artist_genre do
    before(:create) do |artist_genre|
      artist_genre.artist = create(:artist)
      artist_genre.genre = create(:genre)
    end
  end
end