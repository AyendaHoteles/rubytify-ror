# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Song, type: :model do
  describe '.create' do
    subject(:song) { create(:song) }

    context 'relationships' do
      it 'should belongs to artist' do
        expect(described_class.reflect_on_association(:album).macro)
          .to eq :belongs_to
      end
    end

    context 'valid' do
      it 'is valid with this attributes' do
        expect(song).to be_valid
      end
    end

    context 'validations' do
      it 'should have attributes presences' do
        is_expected.to validate_presence_of(:name)
        is_expected.to validate_presence_of(:preview_url)
        is_expected.to validate_presence_of(:spotify_url)
        is_expected.to validate_presence_of(:spotify_id)
      end
    end
  end
end
