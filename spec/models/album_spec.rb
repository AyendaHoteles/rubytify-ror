require "rails_helper"

RSpec.describe Album, type: :model do
  describe "validation model album" do
    it "validation of requiere fileds" do
      should validate_presence_of(:name)
    end

    it "relations_valid?" do
      should have_many(:songs)
    end
  end
end
