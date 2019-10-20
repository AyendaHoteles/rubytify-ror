require 'rails_helper'

RSpec.describe Album, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_uniqueness_of(:spotify_id) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:total_tracks) }
  end

  context 'associations' do
    it { belong_to(:artist) }
  end
end
