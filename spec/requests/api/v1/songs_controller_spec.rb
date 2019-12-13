describe Api::V1::SongsController, type: :request do
  describe 'GET /album/:id/songs' do
    let(:album) { create(:album) }
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
end
