require "rails_helper"

RSpec.describe Album, type: :model do
  describe "validation model album" do
    it "validation of requiere fileds" do
      should validate_presence_of(:name)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:total_tracks)
      should validate_presence_of(:spotify_id)
    end

    it "relations_valid?" do
      should have_many(:songs)
    end
  end
end
