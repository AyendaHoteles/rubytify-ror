require 'rails_helper'

RSpec.describe Album, type: :model do
  
  let(:artist) {Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")}
  let(:album) {Album.create!(name:'el condor herido', image:'dummy_url', spotify_url:'dummy_url', total_tracks:'11', spotify_id:'6rqhFgbbKwnb9MLmUQDhG6', artist: artist)}

  it "is a valid album with valid atributes" do
    expect(album.valid?).to eq(true)
  end

  it "is not valid without name" do
    album.name = nil
    album.valid?
    expect(album.errors[:name]).to eq(["can't be blank"])
  end

  it "is not valid without image" do
    album.image = nil
    album.valid?
    expect(album.errors[:image]).to eq(["can't be blank"])
  end

  it "is not valid without spotify_url" do
    album.spotify_url = nil
    album.valid?
    expect(album.errors[:spotify_url]).to eq(["can't be blank"])
  end

  it "is not valid without total_tracks" do
    album.total_tracks = nil
    album.valid?
    expect(album.errors[:total_tracks]).to eq(["can't be blank"])
  end

  it "is not valid if it does not have at lease 1 track" do
    expect(album.total_tracks).to be > 0
  end
end
