# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items API' do
  before do
    @artist_a = Artist.create!(
      name: 'Tom',
      genres: %w[party electro],
      popularity: 80,
      spotify_url: 'http://open.spotify.com/artist/tom'
    )
    @artist_b = Artist.create!(
      name: 'Mike',
      genres: %w[chill raggae],
      popularity: 100,
      spotify_url: 'http://open.spotify.com/artist/mike'
    )
  end

  describe 'GET /api/v1/artists' do
    before { get '/api/v1/artists' }

    it 'has status code OK' do
      expect(response).to have_http_status(200)
    end

    it 'has content type JSON' do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns all artists' do
      expect(json_body['data'].size).to eq(2)
    end

    # Artist 'Mike' goes first since it has the highest score.
    it 'returns correct json data in the correct order' do
      expect(json_body['data']).to eq(
        [
          {
            'id' => @artist_b.id,
            'name' => 'Mike',
            'genres' => %w[chill raggae],
            'popularity' => 100,
            'spotify_url' => 'http://open.spotify.com/artist/mike'
          },
          {
            'id' => @artist_a.id,
            'name' => 'Tom',
            'genres' => %w[party electro],
            'popularity' => 80,
            'spotify_url' => 'http://open.spotify.com/artist/tom'
          }
        ]
      )
    end
  end
end
