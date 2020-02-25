# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  describe '.create' do
    subject(:album) { create(:album) }

    context 'relationships' do
      it 'should belongs to artist' do
        expect(described_class.reflect_on_association(:artist).macro)
          .to eq :belongs_to
      end

      it 'should has many songs' do
        expect(described_class.reflect_on_association(:songs).macro)
          .to eq :has_many
      end
    end

    context 'valid' do
      it 'is valid with this attributes' do
        expect(album).to be_valid
      end
    end

    context 'validations' do
      it 'should have attributes presences' do
        is_expected.to validate_presence_of(:name)
        is_expected.to validate_presence_of(:image)
        is_expected.to validate_presence_of(:spotify_url)
        is_expected.to validate_presence_of(:spotify_id)
      end
    end
  end
end
