require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  let!(:artist) {Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")}
  let!(:album) {Album.create!(name:'el condor herido', image:'dummy_url', spotify_url:'dummy_url', total_tracks:'11', spotify_id:'6rqhFgbbKwnb9MLmUQDhG6', artist: artist)}
  
  describe "#index" do

    it "Returns root node Data" do
      get :index, params: { artist_id: artist.id}     
      json = JSON.parse(response.body)
      expect(json).to have_key("data")
    end

    it "Returns album information" do
      get :index, params: { artist_id: artist.id}     
      json = JSON.parse(response.body)
      first_album = json["data"].first
      expect(first_album).to eq({"id"=>album.id, "name"=>"el condor herido", "image"=>"dummy_url", "spotify_url"=>"dummy_url", "total_tracks"=>11})
    end
  end
end
