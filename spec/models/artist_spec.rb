require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'Associations' do
    it 'is expected to raise an error' do
      artist_one = create(:artist, name: "Muse")
      artist_two = build(:artist, name: "Muse")
      expect(artist_two.save).to eq false
    end

    it 'has many albums' do
      relation = described_class.reflect_on_association(:albums)
      expect(relation.macro).to eq :has_many
    end
  end
end