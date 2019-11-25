require 'rails_helper'

RSpec.describe Api::V1::SongsController, type: :controller do
  let!(:artist) {artist= Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")}
  let!(:album){album = Album.create!(name:'el condor herido', image:'dummy_url', spotify_url:'dummy_url', total_tracks:'11', spotify_id:'6rqhFgbbKwnb9MLmUQDhG6', artist: artist) } 
  let!(:song) {song = Song.create!(name:"song one", spotify_url:"dummy_url", preview_url:"dummy_url", duration_ms: 9870, explicit: true, spotify_id:'6rqhFgbbKwnb9MLmUQDhG6', album: album )}

  describe "#index" do
    it "Returns root node Data" do
      get :index, params: { id: album.id}     
      json = JSON.parse(response.body)
      expect(json).to have_key("data")
    end

    it "Returns album information" do
      get :index, params: { id: album.id}     
      json = JSON.parse(response.body)
      first_song = json["data"].first
      expect(first_song).to eq({"name"=>"song one", "spotify_url"=>"dummy_url", "preview_url"=>"dummy_url", "duration_ms"=>9870, "explicit"=>true, "album_id"=>album.id})
    end
  end

  describe "#radom" do
    it "Returns album information" do
      get :random, params: { genre_name: "vallenato"}     
      json = JSON.parse(response.body)
      expect(json).to eq({"name"=>"song one", "spotify_url"=>"dummy_url", "preview_url"=>"dummy_url", "duration_ms"=>9870, "explicit"=>true})
    end
  end
end
