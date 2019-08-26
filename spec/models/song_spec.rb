require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'Associations' do
    
    it 'belongs to album' do
      relation = described_class.reflect_on_association(:album)
      expect(relation.macro).to eq :belongs_to
    end
  end
end