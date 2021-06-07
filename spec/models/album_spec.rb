require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:total_tracks)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:spotify_id)
      should validate_presence_of(:artist_id)
    end

    it 'validate belong_to relation to an artist' do
      should belong_to(:artist)
    end

    it 'validate has_many relation to songs' do
      should have_many(:songs)
    end
  end
end
