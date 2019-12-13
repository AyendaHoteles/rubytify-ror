describe Artist do
  describe '.validations' do
    it 'requires a name' do
      artist = build(:artist, name: nil)
      expect(artist).not_to be_valid
      expect(artist.errors.full_messages).to include "Name can't be blank"
    end

    it 'requires a spotify_id' do
      artist = build(:artist, spotify_id: nil)
      expect(artist).not_to be_valid
      expect(artist.errors.full_messages).to include "Spotify can't be blank"
    end

    it 'requires a unique spotify_id' do
      spotify_id = 'ABCD'
      create(:artist, spotify_id: spotify_id)
      artist = build(:artist, spotify_id: spotify_id)
      expect(artist).not_to be_valid
      expect(artist.errors.full_messages).to include 'Spotify has already been taken'
    end
  end
end
