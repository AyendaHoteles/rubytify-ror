require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "validations" do
    it "should validate required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
    end

    it "should belongs to an artist" do
      should belong_to(:artist)
    end
    it "shold have many songs" do
      should have_many(:songs)
    end
  end
end
