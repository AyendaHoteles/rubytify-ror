require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  context 'GET #/api/v1/artists/:id/albums controller => Action api/v1/albums#index' do
    it 'returns a success response on controller Albums' do
      artist = Artist.create!(name: 'Diomedez Diaz', image: 'img.png', genres: 'generes', popularity: 'popular', spotify_url: 'www.da.com')
      album = Album.create!(name: 'album 1', image: 'img.png', spotify_url: 'generes', total_tracks: 10, artist_id: artist.id)
      get :index, params: {id: artist.id}
      response.successful?
    end
  end
end
