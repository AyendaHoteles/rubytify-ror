require 'rails_helper'

RSpec.describe Album, type: :model do
  before(:example) do
    @album = Album.create!(name:'el condor herido', image:'dummy_url', spotify_url:'dummy_url', total_tracks:'11', spotify_id:'6rqhFgbbKwnb9MLmUQDhG6')
  end

  it "is a valid album with valid atributes" do
    expect(@album.valid?).to eq(true)
  end

  it "is not valid without name" do
    @album.name = nil
    expect(@lbum.valid?).to eq(false)
  end

  it "is not valid without image" do
    @album.image = nil
    expect(@album.valid?).to eq(false)
  end

  it "is not valid without spotify_url" do
    @album.spotify_url=nil
    expect(@album.valid?).to eq(false)
  end

  it "is not valid without total_tracks" do
    @album.total_tracks = nil
    expect(@album.valid?).to eq(false)
  end

  it "is not valid if it does not have at lease 1 track" do
    expect(@album.total_tracks).to be > 0
  end
end
