require 'rails_helper'

RSpec.describe Api::V1::GenresController, type: :controller do
  context 'GET #/api/v1/genres/:genre_name/random_song controller => Action api/v1/genres#random_son' do
    it 'returns a success response' do
      artist = Artist.create!(name: 'Diomedez Diaz', image: 'img.png', genres: 'generes', popularity: 'popular', spotify_url: 'www.da.com')
      album = Album.create!(name: 'album 1', image: 'img.png', spotify_url: 'generes', total_tracks: 10, artist_id: artist.id)
      song = Song.create!(name:'cancion 2', spotify_url: 'url1.com', preview_url: 'url_pre.com', duration_ms: 10, explicit: true, album_id: album.id)
      get :random_song, params: {genre_name: artist.genres}
      response.successful?
    end
  end
end
