require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "Test validations" do
    it "validate presence of fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:image)
      should validate_presence_of(:genres)
      should validate_presence_of(:popularity)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
    end
    
    it "validate has_many albums" do
      should have_many(:albums)
    end
  end
end
