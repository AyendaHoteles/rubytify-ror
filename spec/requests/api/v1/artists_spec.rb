# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Artists API' do
  let!(:artist_a) do
    Artist.create!(
      name: 'Tom',
      genres: %w[party electro],
      popularity: 80,
      spotify_url: 'http://open.spotify.com/artists/tom'
    )
  end

  let!(:artist_b) do
    Artist.create!(
      name: 'Mike',
      genres: %w[chill raggae],
      popularity: 100,
      spotify_url: 'http://open.spotify.com/artists/mike'
    )
  end

  let!(:image_a) do
    Image.create!(
      height: 10,
      width: 10,
      url: 'http://open.spotify.com/images/tom',
      owner: artist_a
    )
  end

  let!(:image_b) do
    Image.create!(
      height: 10,
      width: 10,
      url: 'http://open.spotify.com/images/mike',
      owner: artist_b
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
            'id' => artist_b.id,
            'name' => 'Mike',
            'genres' => %w[chill raggae],
            'popularity' => 100,
            'spotify_url' => 'http://open.spotify.com/artists/mike',
            'image' => {
              'height' => 10,
              'width' => 10,
              'url' => 'http://open.spotify.com/images/mike'
            }
          },
          {
            'id' => artist_a.id,
            'name' => 'Tom',
            'genres' => %w[party electro],
            'popularity' => 80,
            'spotify_url' => 'http://open.spotify.com/artists/tom',
            'image' => {
              'height' => 10,
              'width' => 10,
              'url' => 'http://open.spotify.com/images/tom'
            }
          }
        ]
      )
    end
  end
end
