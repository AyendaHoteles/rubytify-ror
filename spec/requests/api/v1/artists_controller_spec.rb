describe Api::V1::ArtistsController, type: :request do
  describe 'GET /artists' do
    let!(:artists) do
      [
        create(:artist, popularity: 10),
        create(:artist, popularity: 50),
        create(:artist, popularity: 90)
      ]
    end

    def do_request
      get(api_v1_artists_path)
    end

    it 'sets the content type as json' do
      do_request
      expect(response.headers['Content-Type']).to match(%r{^application/json.*})
    end

    it 'returns all artist' do
      do_request
      results = JSON.parse(response.body)
      expect(results['data'].count).to eq 3
      record_ids = results['data'].map { |artist| artist['id'] }
      expect(record_ids).to match_array artists.map(&:id)
    end

    it 'returns them in order of popularity' do
      do_request
      results = JSON.parse(response.body)
      record_ids = results['data'].map { |artist| artist['id'] }
      expect(record_ids[0]).to eq artists[2].id
      expect(record_ids[1]).to eq artists[1].id
      expect(record_ids[2]).to eq artists[0].id
    end

    it 'returns them in the expected format' do
      do_request
      results = JSON.parse(response.body)
      record = results['data'].first
      sorted_keys = record.keys.sort
      expect(sorted_keys).to eq %w[genres id image name popularity spotify_url]
    end
  end

  describe 'GET /artists/:id/albums' do
    let(:artist) { create(:artist) }
    let!(:albums) do
      [
        create(:album, artist: artist),
        create(:album, artist: artist)
      ]
    end

    def do_request(artist_id)
      get(api_v1_artist_albums_path(artist_id))
    end

    it 'sets the content type as json' do
      do_request(0)
      expect(response.headers['Content-Type']).to match(%r{^application/json.*})
    end

    it 'returns all albums of the given artist' do
      do_request(artist)
      results = JSON.parse(response.body)
      record_ids = results['data'].map { |album| album['id'] }
      expect(record_ids).to match_array albums.map(&:id)
    end

    it 'returns them in the expected format' do
      do_request(artist)
      results = JSON.parse(response.body)
      record = results['data'].first
      sorted_keys = record.keys.sort
      expect(sorted_keys).to eq %w[id image name spotify_url total_tracks]
    end

    it 'returns 404 if the artist is not found' do
      do_request(0)
      expect(response).to be_not_found
    end
  end
end
