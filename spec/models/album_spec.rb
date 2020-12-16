require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:spotify_id) }
    it { is_expected.to validate_presence_of(:total_tracks) }
    it { should validate_numericality_of(:total_tracks) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_many(:songs) }
  end
end
