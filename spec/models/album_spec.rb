require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'Associations' do

    it 'has many songs' do
      relation = described_class.reflect_on_association(:songs)
      expect(relation.macro).to eq :has_many
    end

    it 'belongs to artist' do
      relation = described_class.reflect_on_association(:artist)
      expect(relation.macro).to eq :belongs_to
    end
  end
end