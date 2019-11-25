require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
    let!(:artist) {Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")}

    describe "#index" do
      it "Returns a valid response" do
        get :index
        expect(response.status).to eq(200)
      end

      it "Returns root node Data" do
        get :index
        json = JSON.parse(response.body)
        expect(json).to have_key("data")
      end

      it "Returns artist information" do
        get :index
        json = JSON.parse(response.body)
        first_artist = json["data"].first
        expect(first_artist).to eq({"id"=>artist.id, "name"=>"Diomedes Diaz", "image"=>"dummy_url", "genres"=>["vallenato", "folk"], "popularity"=>25, "spotify_url"=>"dummy_url"})
      end
    end
end
