# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Albums API' do
  let!(:artist) do
    Artist.create!(
      name: 'Tom',
      genres: %w[party electro],
      popularity: 80,
      spotify_url: 'http://open.spotify.com/artists/tom'
    )
  end

  let!(:album_a) do
    Album.create!(
      name: 'Moiz',
      total_tracks: 10,
      spotify_url: 'http://open.spotify.com/albums/moiz',
      artist: artist
    )
  end

  let!(:album_b) do
    Album.create!(
      name: 'Yucko',
      total_tracks: 20,
      spotify_url: 'http://open.spotify.com/albums/yucko',
      artist: artist
    )
  end

  let!(:image_a) do
    Image.create!(
      height: 10,
      width: 10,
      url: 'http://open.spotify.com/images/moiz',
      owner: album_a
    )
  end

  let!(:image_b) do
    Image.create!(
      height: 10,
      width: 10,
      url: 'http://open.spotify.com/images/yucko',
      owner: album_b
    )
  end

  describe 'GET /api/v1/albums' do
    before { get "/api/v1/artists/#{artist.id}/albums" }

    it 'has status code OK' do
      expect(response).to have_http_status(200)
    end

    it 'has content type JSON' do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns all albums' do
      expect(json_body['data'].size).to eq(2)
    end

    it 'returns correct json data' do
      expect(json_body['data']).to eq(
        [
          {
            'id' => album_a.id,
            'name' => 'Moiz',
            'spotify_url' => 'http://open.spotify.com/albums/moiz',
            'total_tracks' => 10,
            'image' => {
              'height' => 10,
              'width' => 10,
              'url' => 'http://open.spotify.com/images/moiz'
            }
          },
          {
            'id' => album_b.id,
            'name' => 'Yucko',
            'spotify_url' => 'http://open.spotify.com/albums/yucko',
            'total_tracks' => 20,
            'image' => {
              'height' => 10,
              'width' => 10,
              'url' => 'http://open.spotify.com/images/yucko'
            }
          }
        ]
      )
    end
  end
end
