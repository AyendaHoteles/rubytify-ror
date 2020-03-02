require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:spotify_url) }
    it { is_expected.to validate_presence_of(:spotify_id) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:albums) }
    it { is_expected.to have_many(:songs).through(:albums) }
  end
end
