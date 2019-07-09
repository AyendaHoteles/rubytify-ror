require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_many(:songs) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:spotify_id) }
    it { is_expected.to validate_presence_of(:spotify_url) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:artist_id) }
    it { is_expected.to validate_uniqueness_of(:spotify_id) }
    it { is_expected.to validate_uniqueness_of(:spotify_url) }
  end
end
