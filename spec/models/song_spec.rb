require "rails_helper"

RSpec.describe Song, type: :model do
  describe "Test validations" do
    it "validate presence of model fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:preview_url)
      should validate_presence_of(:duration_ms)

      # Warning from shoulda-matchers:
      # You are using `validate_inclusion_of` to assert booleans. Be aware that it
      # ... Hence, you should consider removing this test.
      # should validate_inclusion_of(:explicit).
      #   in_array([true, false])
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
    end
  end
end
