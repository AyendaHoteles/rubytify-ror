require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:spotify_id) }
    it { is_expected.to validate_presence_of(:duration_ms) }
    it { should validate_numericality_of(:duration_ms) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:album) }
  end
end
