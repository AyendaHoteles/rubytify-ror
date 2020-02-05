require 'rails_helper'

RSpec.describe Album, type: :model do
  fixtures :albums, :songs, :artists
  describe 'associations' do
    it { should have_many(:songs) }
    it { should belong_to(:artist) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:total_tracks) }
    it { should validate_presence_of(:spotify_id) }
  end
end
