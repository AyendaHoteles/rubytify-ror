require "rails_helper"

RSpec.describe Album, :type => :model do
  context "validation tests" do
    before(:each) do
      @album = build(:album)
    end
    describe "validations" do
      it "is valid with valid attributes" do
        expect(@album).to be_valid
      end
      it "is not valid without a name" do
        @album.name = ""
        expect(@album).to_not be_valid
      end
      it "is not valid without an spotify_url" do
        @album.spotify_url = ""
        expect(@album).to_not be_valid
      end
      it "is not valid without an spotify_id" do
        @album.spotify_id = ""
        expect(@album).to_not be_valid
      end
    end
    describe "associations" do
      it { should belong_to(:artist) }
      it{ is_expected.to have_many(:songs) }
    end
  end
end
