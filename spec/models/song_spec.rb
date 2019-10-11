require "rails_helper"

RSpec.describe Song, :type => :model do
  context "validation tests" do
    before(:each) do
      @song = build(:song)
    end
    describe "validations" do
      it "is valid with valid attributes" do
        expect(@song).to be_valid
      end
      it "is not valid without a name" do
        @song.name = ""
        expect(@song).to_not be_valid
      end
      it "is not valid without an spotify_url" do
        @song.spotify_url = ""
        expect(@song).to_not be_valid
      end
      it "is not valid without an spotify_id" do
        @song.spotify_id = ""
        expect(@song).to_not be_valid
      end
      it "is not valid without an duration_ms" do
        @song.duration_ms = ""
        expect(@song).to_not be_valid
      end
    end
    describe "associations" do
      it { should belong_to(:album) }
    end
  end
end
