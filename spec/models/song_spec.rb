require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:spotify_url) }
    it { is_expected.to validate_presence_of(:spotify_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:album) }
  end

  context 'methods' do
    describe 'random_song_by_genre' do
      let!(:artist1) { FactoryBot.create(:artist, genres: ['salsa']) }
      let!(:artist2) { FactoryBot.create(:artist, genres: ['vallenato']) }
      let!(:album1)  { FactoryBot.create(:album, artist: artist1) }
      let!(:album2)  { FactoryBot.create(:album, artist: artist2) }
      let!(:song)    { FactoryBot.create(:song, album: album1) }
      let!(:song2)   { FactoryBot.create(:song, album: album2) }

      it { expect(Song.random_song_by_genre('vallenato').name).to eq(song2.name) }
      it { expect(Song.random_song_by_genre('salsa').name).to eq(song.name) }
      it { expect(Song.random_song_by_genre('reggaaeton')).to be_nil }
    end
  end
end
