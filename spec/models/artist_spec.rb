require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "validations" do
    it "should validate required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
    end

    it "should has many albums" do
      should have_many(:albums)
      should have_many(:songs)
    end
  end
end
