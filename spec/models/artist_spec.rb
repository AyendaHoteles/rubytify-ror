# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe '.create' do
    subject(:artist) { create(:artist) }

    context 'relationships' do
      it 'should has many albums' do
        expect(described_class.reflect_on_association(:albums).macro)
          .to eq :has_many
      end
    end

    context 'valid' do
      it 'is valid with this attributes' do
        expect(artist).to be_valid
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
