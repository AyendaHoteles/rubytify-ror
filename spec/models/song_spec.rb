require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:duration_ms)
      should validate_presence_of(:explicit)
      should validate_presence_of(:preview_url)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
      should validate_presence_of(:album_id)
    end
  end
end
