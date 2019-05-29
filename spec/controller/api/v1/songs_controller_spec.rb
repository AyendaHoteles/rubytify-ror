# spec/controllers/api/v1/songs_controller_spec.rb

require 'rails_helper'
RSpec.describe Api::V1::SongsController, :type => :controller  do

  before(:all) do
    @artist = create(:artist, genres: 'rock')
    @album = create(:album, artist: @artist)
    @song = create(:song, album: @album)
  end

  describe "GET songs#random_song_genre" do

    it "returns http success" do
      get :random_song_genre, params: {genre_name: 'rock'}
      expect(response).to have_http_status(:success)
    end

  end
end