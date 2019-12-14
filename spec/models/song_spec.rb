require "rails_helper"

RSpec.describe Song, type: :model do
  describe "validation model song" do
    it "validation of requiere fileds" do
      should validate_presence_of(:name)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:duration_ms)
      should validate_presence_of(:explicit)
      should validate_presence_of(:spotify_id)
    end

    it "relations_valid?" do
      should belong_to(:album)
    end
  end
end
