require 'rails_helper'

RSpec.describe Artist, type: :model do
  before(:example) do
    @artist= Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")
  end

  it "is valid with valid attributes" do
    expect(@artist.valid?).to eq(true)
  end

  it "is not valid without name" do
    @artist.name = nil
    expect(@artist.valid?).to eq(false)
  end

  it "is not valid without image" do
    @artist.image = nil
    expect(@artist.valid?).to eq(false)
  end

  it "is not valid without genres" do
    @artist.genres=[]
    expect(@artist.valid?).to eq(false)
  end

  it "is not valid without popularity" do
    @artist.popularity=nil
    expect(@artist.valid?).to eq(false)
  end

  it "is not valid without spotify url" do
    @artist.spotify_url= nil
    expect(@artist.valid?).to eq(false)
  end

  it "is not valid without spotify id" do
    @artist.spotify_id = nil
    expect(@artist.valid?).to eq(false)
  end
end
