describe DemoData::Populator do
  describe '#process' do
    let(:artist_data) do
      {
        name: 'Octavio Mesa',
        image_url: 'https://image.com',
        genres: %w[popular carrilera],
        popularity: 100,
        spotify_url: "https://example.com/artist/#{artist_spotify_id}"
      }
    end
    let(:artist_spotify_id) { 'ABCD' }
    let(:artist_mock) do
      double(RSpotify::Artist, name: artist_data[:name],
                               images: [artist_image_hash],
                               genres: artist_data[:genres],
                               popularity: 100,
                               external_urls: { 'spotify' => artist_data[:spotify_url] },
                               id: artist_spotify_id,
                               albums: [album_mock])
    end
    let(:artist_image_hash) do
      {
        'height' => 640,
        'url' => artist_data[:image_url],
        'width' => '640'
      }
    end
    let(:album_data) do
      {
        name: 'Relajos del arriero',
        image_url: 'https://image.com/album.png',
        spotify_url: "https://example.com/album/#{album_spotify_id}",
        total_tracks: 1
      }
    end
    let(:album_spotify_id) { 'FGH' }
    let(:album_mock) do
      double(RSpotify::Album, name: album_data[:name],
                              images: [album_image_hash],
                              external_urls: { 'spotify' => album_data[:spotify_url] },
                              id: album_spotify_id,
                              total_tracks: album_data[:total_tracks],
                              tracks: [song_mock])
    end
    let(:album_image_hash) do
      {
        'height' => 640,
        'url' => album_data[:image_url],
        'width' => '640'
      }
    end
    let(:song_data) do
      {
        name: 'Trovas',
        spotify_url: "https://example.com/album/#{song_spotify_id}",
        preview_url: 'preview.com',
        duration_ms: 456789,
        explicit: true
      }
    end
    let(:song_spotify_id) { 'JKL' }
    let(:song_mock) do
      double(RSpotify::Track, name: song_data[:name],
                              external_urls: { 'spotify' => song_data[:spotify_url] },
                              id: song_spotify_id,
                              preview_url: song_data[:preview_url],
                              duration_ms: song_data[:duration_ms],
                              explicit: song_data[:explicit])
    end

    before do
      allow(RSpotify::Artist).to receive(:search).and_return([artist_mock])
    end

    it 'creates artists from Spotify' do
      expect do
        populator = described_class.new([artist_data[:name]])
        populator.process
      end.to change(Artist, :count).by(1)
      artist = Artist.first
      expect(artist.name).to eq artist_data[:name]
      expect(artist.image).to eq artist_data[:image_url]
      expect(artist.genres).to eq artist_data[:genres]
      expect(artist.popularity).to eq artist_data[:popularity]
      expect(artist.spotify_url).to eq artist_data[:spotify_url]
      expect(artist.spotify_id).to eq artist_spotify_id
    end

    it 'creates the albums of the given artists' do
      expect do
        populator = described_class.new([artist_data[:name]])
        populator.process
      end.to change(Album, :count).by(1)
      album = Album.first
      expect(album.name).to eq album_data[:name]
      expect(album.image).to eq album_data[:image_url]
      expect(album.total_tracks).to eq album_data[:total_tracks]
      expect(album.spotify_url).to eq album_data[:spotify_url]
      expect(album.spotify_id).to eq album_spotify_id
    end

    it 'creates the songs of the given artists' do
      expect do
        populator = described_class.new([artist_data[:name]])
        populator.process
      end.to change(Song, :count).by(1)
      song = Song.first
      expect(song.name).to eq song_data[:name]
      expect(song.spotify_url).to eq song_data[:spotify_url]
      expect(song.preview_url).to eq song_data[:preview_url]
      expect(song.duration_ms).to eq song_data[:duration_ms]
      expect(song.explicit).to eq song_data[:explicit]
      expect(song.spotify_id).to eq song_spotify_id
    end
  end
end
