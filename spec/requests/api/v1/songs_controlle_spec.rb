# frozen_string_literal: true

require 'rails_helper'
require 'database_cleaner'

RSpec.describe 'artist API', type: :request do
  describe '/api/v1/albums/:album_id/songs' do
    let!(:user) { create(:admin_user) }
    let(:header) { valid_headers }
    let(:invalid_header) { { 'Authorization': nil } }
    context 'when request is valid ' do
      before do
        album = create(:album)
        create_list(:song, 10, album_id: album.id)
        get "/api/v1/albums/#{album.id}/songs", headers: header
      end
      it 'return valid code' do
        expect(response).to have_http_status(200)
      end

      it 'return data key in response' do
        expect(JSON.parse(response.body)).to have_key('data')
      end

      it 'return 10 songs' do
        expect(JSON.parse(response.body)['data'].length).to eq(10)
      end

      it 'return valid song' do
        expect(JSON.parse(response.body)['data'][0]).to have_key('name')
        expect(JSON.parse(response.body)['data'][0]).to have_key('duration_ms')
        expect(JSON.parse(response.body)['data'][0]).to have_key('explicit')
        expect(JSON.parse(response.body)['data'][0]).to have_key('spotify_url')
        expect(JSON.parse(response.body)['data'][0]).to have_key('preview_url')
        expect(JSON.parse(response.body)['data'][0]).to have_key('spotify_id')
      end
    end
    context 'when request is invalid ' do
      before do
        album = create(:album)
        create_list(:song, 10, album_id: album.id)
        get "/api/v1/albums/#{album.id}/songs", headers: invalid_header
      end
      it 'return valid code' do
        expect(response).to have_http_status(422)
      end
    end
    context 'when artist does not exist' do
      before do
        get '/api/v1/albums/1/songs', headers: header
      end
      it 'return valid code' do
        expect(response).to have_http_status(404)
      end
    end

    describe '/api/v1/genres/:genre_name/random_song' do
      context 'fetch a random song when genre exist' do
        before do
          album = create(:album)
          create_list(:song, 10, album_id: album.id)
          genre = create(:genre)
          album.artist.genres << genre
          get "/api/v1/genres/#{genre.name}/random_song", headers: header
        end

        it 'return valid code' do
          expect(response).to have_http_status(200)
        end

        it 'return data key in response' do
          expect(JSON.parse(response.body)).to have_key('data')
        end

        it 'return valid song' do
          expect(JSON.parse(response.body)['data']).to have_key('name')
          expect(JSON.parse(response.body)['data']).to have_key('duration_ms')
          expect(JSON.parse(response.body)['data']).to have_key('explicit')
          expect(JSON.parse(response.body)['data']).to have_key('spotify_url')
          expect(JSON.parse(response.body)['data']).to have_key('preview_url')
          expect(JSON.parse(response.body)['data']).to have_key('spotify_id')
        end
      end

      context 'when request is invalid ' do
        before do
          album = create(:album)
          create_list(:song, 10, album_id: album.id)
          genre = create(:genre)
          album.artist.genres << genre
          get "/api/v1/genres/#{genre.name}/random_song", headers: invalid_header
        end
        it 'return valid code' do
          expect(response).to have_http_status(422)
        end
      end

      context 'when genre does not exist ' do
        before do
          get "/api/v1/genres/'latin'/random_song", headers: header
        end
        it 'return valid code' do
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end