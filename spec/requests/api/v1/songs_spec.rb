# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Songs API' do
  let!(:artist) do
    Artist.create!(
      name: 'Tom',
      genres: %w[party electro],
      popularity: 80,
      spotify_url: 'http://open.spotify.com/artists/tom'
    )
  end

  let!(:album) do
    Album.create!(
      name: 'Moiz',
      total_tracks: 10,
      spotify_url: 'http://open.spotify.com/albums/moiz',
      artist: artist
    )
  end

  let!(:song_a) do
    Song.create!(
      name: 'hey',
      spotify_url: 'http://open.spotify.com/songs/hey',
      preview_url: 'http://open.spotify.com/songs/previews/hey',
      duration_ms: 10_000,
      explicit: false,
      album: album
    )
  end

  let!(:song_b) do
    Song.create!(
      name: 'you',
      spotify_url: 'http://open.spotify.com/songs/you',
      preview_url: 'http://open.spotify.com/songs/previews/you',
      duration_ms: 20_000,
      explicit: true,
      album: album
    )
  end

  describe 'GET /api/v1/albums/:album_id/songs' do
    before { get "/api/v1/albums/#{album.id}/songs" }

    it 'has status code OK' do
      expect(response).to have_http_status(200)
    end

    it 'has content type JSON' do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns all songs' do
      expect(json_body['data'].size).to eq(2)
    end

    it 'returns correct json data' do
      expect(json_body['data']).to eq(
        [
          {
            'name' => 'hey',
            'spotify_url' => 'http://open.spotify.com/songs/hey',
            'preview_url' => 'http://open.spotify.com/songs/previews/hey',
            'duration_ms' => 10_000,
            'explicit' => false
          },
          {
            'name' => 'you',
            'spotify_url' => 'http://open.spotify.com/songs/you',
            'preview_url' => 'http://open.spotify.com/songs/previews/you',
            'duration_ms' => 20_000,
            'explicit' => true
          }
        ]
      )
    end
  end
end
