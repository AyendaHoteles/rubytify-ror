require 'rails_helper'

RSpec.describe Artist, type: :model do
    let(:artist) {Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")}

    it "is valid with valid attributes" do
      expect(artist.valid?).to eq(true)
    end

    it "is not valid without name" do
      artist.name = nil
      artist.valid?
      expect(artist.errors[:name]).to eq(["can't be blank"])
    end

    it "is not valid without image" do
      artist.image = nil
      artist.valid?
      expect(artist.errors[:image]).to eq(["can't be blank"])
    end

    it "is not valid without genres" do
      artist.genres=[]
      artist.valid?
      expect(artist.errors[:genres]).to eq(["can't be blank"])

    end

    it "is not valid without popularity" do
      artist.popularity = nil
      artist.valid?
      expect(artist.errors[:popularity]).to eq(["can't be blank"])
  end

    it "is not valid without spotify url" do
      artist.spotify_url = nil
      artist.valid?
      expect(artist.errors[:spotify_url]).to eq(["can't be blank"])
  end

    it "is not valid without spotify id" do
      artist.spotify_id = nil
      artist.valid?
      expect(artist.errors[:spotify_id]).to eq(["can't be blank"])
  end
end
