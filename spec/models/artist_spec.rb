require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:albums) }
    it { is_expected.to have_many(:songs) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:spotify_id) }
    it { is_expected.to validate_presence_of(:spotify_url) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:spotify_id) }
    it { is_expected.to validate_uniqueness_of(:spotify_url) }
  end
end
