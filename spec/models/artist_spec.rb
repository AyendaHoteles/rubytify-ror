require "rails_helper"

RSpec.describe Artist, type: :model do
  describe "validation model artist" do
    it "validation of requiere fileds" do
      should validate_presence_of(:name)
    end

    it "relations_valid?" do
      should have_many(:albums)
    end
  end
end
