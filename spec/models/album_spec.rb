require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "Test validations" do
    it "validate presence of model fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:image)
      should validate_presence_of(:total_tracks)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
    end
    
    it "validate has_many albums" do
      should have_many(:songs)
    end
  end
end
