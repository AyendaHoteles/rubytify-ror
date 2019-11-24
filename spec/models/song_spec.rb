require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:artist) {artist= Artist.create!(name:"Diomedes Diaz", image:"dummy_url", genres:["vallenato", "folk"],popularity:25, spotify_url:"dummy_url", spotify_id: "6rqhFgbbKwnb9MLmUQDhG6")}
  let(:album){album = Album.create!(name:'el condor herido', image:'dummy_url', spotify_url:'dummy_url', total_tracks:'11', spotify_id:'6rqhFgbbKwnb9MLmUQDhG6', artist: artist) } 
  let(:song) {song = Song.create!(name:"song one", spotify_url:"dummy_url", preview_url:"dummy_url", duration_ms: 9870, explicit: true, spotify_id:'6rqhFgbbKwnb9MLmUQDhG6', album: album )}

  it "is a valid song with valid attributes" do
    expect(song.valid?).to eq(true)
  end

  it "is not a valid song without name" do
    song.name= nil
    song.valid?
    expect(song.errors[:name]).to eq(["can't be blank"])
  end

  it "is not a valid song without spotify url" do
    song.spotify_url = nil
    song.valid?
    expect(song.errors[:spotify_url]).to eq(["can't be blank"])
  end

  it "is not a valid song without preview url" do
    song.preview_url = nil
    song.valid?
    expect(song.errors[:preview_url]).to eq(["can't be blank"])
  end

  it "is not a valid song without duration" do
    song.duration_ms = nil
    song.valid?
    expect(song.errors[:duration_ms]).to eq(["can't be blank"])
  end

  it "is not a valid song without declaration of explicit" do
    song.explicit = nil
    song.valid?
    expect(song.errors[:explicit]).to eq(["can't be blank"])
  end
end
