require 'rails_helper'

RSpec.describe Api::V1::SongsController, type: :controller do
  context 'GET #/api/v1/albums/:id/songs controller => Action api/v1/songs#index' do
    it 'returns a success response on controller Songs' do
      artist = Artist.create!(name: 'Diomedez Diaz', image: 'img.png', genres: 'generes', popularity: 'popular', spotify_url: 'www.da.com')
      album = Album.create!(name: 'album 1', image: 'img.png', spotify_url: 'generes', total_tracks: 10, artist_id: artist.id)
      song = Song.create!(name:'cancion 2', spotify_url: 'url1.com', preview_url: 'url_pre.com', duration_ms: 10, explicit: true, album_id: album.id)
      get :index, params: {id: album.id}
      response.successful?
    end
  end
end
