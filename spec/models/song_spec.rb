require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:duration_ms)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
      should validate_presence_of(:album_id)
    end

    it 'should belong to an album' do
      should belong_to(:album)
    end
  end
end
