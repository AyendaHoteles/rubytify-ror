require 'rails_helper'

RSpec.describe Album, type: :model do
  
  describe "validations" do
    it "validate presence" do
      should validate_presence_of(:name)
      should validate_presence_of(:image)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:total_tracks)
      should validate_presence_of(:spotify_id)
    end
  end
end
