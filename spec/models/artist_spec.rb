require "rails_helper"

RSpec.describe Artist, :type => :model do
  context "validation tests" do
    before(:each) do
      @artist = build(:artist)
    end
    it "is valid with valid attributes" do
      expect(@artist).to be_valid
    end
    it "is not valid without a name" do
      @artist.name = ""
      expect(@artist).to_not be_valid
    end
    it "is not valid without a spotify_url" do
      @artist.spotify_url = ""
      expect(@artist).to_not be_valid
    end
    it "is not valid without a spotify_id" do
      @artist.spotify_id = ""
      expect(@artist).to_not be_valid
    end
  end
end
