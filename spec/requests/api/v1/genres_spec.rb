# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Genres API' do
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
      preview_url: 'http://open.spotify.com/songs/previews/you',
      duration_ms: 20_000,
      explicit: true,
      album: album
    )
  end

  describe 'GET /api/v1/genres/:genre_name/random_song' do
    context 'when songs are found by genre' do
      before do
        srand(2)
        get '/api/v1/genres/party/random_song'
      end

      it 'has status code OK' do
        expect(response).to have_http_status(200)
      end

      it 'has content type JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns correct json data' do
        expect(json_body['data']).to eq(
          'name' => 'hey',
          'spotify_url' => 'http://open.spotify.com/songs/hey',
          'preview_url' => 'http://open.spotify.com/songs/previews/hey',
          'duration_ms' => 10_000,
          'explicit' => false
        )
      end
    end

    context 'when ANY song found by genre' do
      before { get '/api/v1/genres/troll/random_song' }

      it 'has status code OK' do
        expect(response).to have_http_status(404)
      end

      it 'has content type JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns correct json data' do
        expect(json_body['error']).to eq(
          'We do not have songs matching tha genre troll - come back later'
        )
      end
    end
  end
end
