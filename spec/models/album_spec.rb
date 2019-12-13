describe Album do
  let(:artist) { create(:artist) }

  describe '.validations' do
    it 'requires an artist' do
      album = build(:album, artist: nil)
      expect(album).not_to be_valid
      expect(album.errors.full_messages).to include "Artist can't be blank"
      expect(album.errors.full_messages).to include 'Artist must exist'
    end

    it 'requires a name' do
      album = build(:album, artist: artist, name: nil)
      expect(album).not_to be_valid
      expect(album.errors.full_messages).to include "Name can't be blank"
    end

    it 'requires a spotify_id' do
      album = build(:album, artist: artist, spotify_id: nil)
      expect(album).not_to be_valid
      expect(album.errors.full_messages).to include "Spotify can't be blank"
    end

    it 'requires an unique spotify_id' do
      spotify_id = '123456'
      create(:album, spotify_id: spotify_id)
      album = build(:album, artist: artist, spotify_id: spotify_id)
      expect(album).not_to be_valid
      expect(album.errors.full_messages).to include 'Spotify has already been taken'
    end
  end
end
