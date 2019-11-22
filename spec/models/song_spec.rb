require 'rails_helper'

RSpec.describe Song, type: :model do
  before(:example) do
    @song = Song.create!(name:"song one", spotify_url:"dummy_url", preview_url:"dummy_url", duration_ms: 9870, explicit:false)
  end

  it "is a valid song with valid attributes" do
    expect(@song.valid?).to eq(true)
  end

  it "is not a valid song without name" do
    @song.name= nil
    expect(@song.valid?).to eq(false)
  end

  it "is not a valid song without spotify url" do
    @song.spotify_url = nil
    expect(@song.valid?).to eq(false)
  end

  it "is not a valid song without preview url" do
    @song.preview_url = nil
    expect(@song.valid?).to eq(false)
  end

  it "is not a valid song without duration" do
    @song.duration_ms = nil
    expect(@song.valid?).to eq(false)
  end

  it "is not a valid song without declaration of explicit" do
    @song.explicit = nil
    expect(@song.duration_ms).not_to be_empty
  end
end
