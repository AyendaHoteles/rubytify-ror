require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:spotify_id) }
    it { is_expected.to validate_presence_of(:popularity) }
    it { should validate_numericality_of(:popularity) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:albums) }
  end

end
