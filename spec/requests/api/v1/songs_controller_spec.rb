describe Api::V1::SongsController, type: :request do
  let(:artist) { create(:artist, genres: ['carrilera']) }
  let(:album) { create(:album, artist: artist) }

  describe 'GET /album/:id/songs' do
    let!(:songs) do
      [
        create(:song, album: album),
        create(:song, album: album)
      ]
    end

    def do_request(album_id)
      get(api_v1_album_songs_path(album_id))
    end

    it 'sets the content type as json' do
      do_request(0)
      expect(response.headers['Content-Type']).to match(%r{^application/json.*})
    end

    it 'returns all the songs of the given album' do
      do_request(album)
      results = JSON.parse(response.body)
      record_names = results['data'].map { |song| song['name'] }
      expect(record_names).to match_array songs.map(&:name)
    end

    it 'returns them in the expected format' do
      do_request(album)
      results = JSON.parse(response.body)
      record = results['data'].first
      sorted_keys = record.keys.sort
      expect(sorted_keys).to eq %w[duration_ms explicit name preview_url spotify_url]
    end

    it 'returns 404 if the album is not found' do
      do_request(0)
      expect(response).to be_not_found
    end
  end

  describe 'GET /genres/:genre_name/random_song' do
    let(:genre_name) { 'rock' }
    let(:rock_artist) { create(:artist, genres: [genre_name]) }
    let(:rock_album) { create(:album, artist: rock_artist) }
    let!(:rock_songs) do
      [
        create(:song, album: rock_album),
        create(:song, album: rock_album)
      ]
    end
    let!(:other_songs) do
      [
        create(:song, album: album),
        create(:song, album: album)
      ]
    end

    def do_request(genre)
      get(api_v1_genre_random_song_path(genre))
    end

    it 'sets the content type as json' do
      do_request(0)
      expect(response.headers['Content-Type']).to match(%r{^application/json.*})
    end

    it 'returns a song of the given genre' do
      do_request(genre_name)
      results = JSON.parse(response.body)
      record = results['data']
      expect(rock_songs.pluck(:name)).to include record['name']
    end

    it 'returns the song in the expected format' do
      do_request(genre_name)
      results = JSON.parse(response.body)
      sorted_keys = results['data'].keys.sort
      expect(sorted_keys).to eq %w[duration_ms explicit name preview_url spotify_url]
    end

    it 'returns 404 if the album is not found' do
      do_request(0)
      expect(response).to be_not_found
    end
  end
end
