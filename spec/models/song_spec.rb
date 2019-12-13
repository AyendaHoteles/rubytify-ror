describe Song do
  let(:album) { create(:album) }

  describe '.validations' do
    it 'requires an album' do
      song = build(:song, album: nil)
      expect(song).not_to be_valid
      expect(song.errors.full_messages).to include 'Album must exist'
      expect(song.errors.full_messages).to include "Album can't be blank"
    end

    it 'requires a name' do
      song = build(:song, album: album, name: nil)
      expect(song).not_to be_valid
      expect(song.errors.full_messages).to include "Name can't be blank"
    end

    it 'requires a spotify_id' do
      song = build(:song, album: album, spotify_id: nil)
      expect(song).not_to be_valid
      expect(song.errors.full_messages).to include "Spotify can't be blank"
    end

    it 'requires a unique spotify_id' do
      spotify_id = 'QWER'
      create(:song, spotify_id: spotify_id)
      song = build(:song, album: album, spotify_id: spotify_id)
      expect(song).not_to be_valid
      expect(song.errors.full_messages).to include 'Spotify has already been taken'
    end
  end
end
