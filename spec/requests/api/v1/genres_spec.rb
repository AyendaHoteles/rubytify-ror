require 'rails_helper'

RSpec.describe 'Genres', type: :request do
   
   it 'returns the correct song' do
   
      artist = Artist.create(name: 'Dummy',
                             genres: ['rock', 'pop'].to_json,
                             popularity: 8,
                             spotify_url: "https://spotify.com",
                             spotify_id: 345)
                             
      album = Album.create(name: 'Album Dummy',
                           total_tracks: 10,
                           spotify_url: "https://spotify.com",
                           spotify_id: 666,
                           artist_id: artist.id)
                           
      song = Song.create(name: 'Song Dummy',
                         preview_url: "https://spotify.com/preview",
                         duration_ms: 3200,
                         explicit: true,
                         spotify_url: "https://spotify.com",
                         spotify_id: 999,
                         album_id: album.id)
      
      get '/api/v1/genres/rock/random_song'
      
      body = JSON.parse(response.body)
      expect(body['data']['name']).to eq('Song Dummy')
   end
end
