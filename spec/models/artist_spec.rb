# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:image).dependent(:destroy) }
    it { is_expected.to have_many(:albums).dependent(:destroy) }
  end

  describe 'callbacks' do
    let(:artist) { Artist.create! }

    it 'fires delete_cache method as before_update method callbacks' do
      expect(artist).to receive(:delete_cache).and_call_original
      artist.run_callbacks(:update)
    end

    it 'fires delete_cache method as before_destroy method callbacks' do
      expect(artist).to receive(:delete_cache).and_call_original
      artist.run_callbacks(:destroy)
    end
  end

  describe 'named scopes' do
    describe '.by_genre' do
      let(:artist_a) { Artist.create!(genres: ['party']) }
      let(:artist_b) { Artist.create!(genres: ['chill']) }

      context 'when genre matches exactly' do
        it 'returns artists filter by genre' do
          expect(
            Artist.by_genre('party')
          ).to include(artist_a)

          expect(
            Artist.by_genre('party')
          ).not_to include(artist_b)
        end
      end

      context 'when genre does NOT matches exactly' do
        it 'returns artists filter by genre' do
          expect(
            Artist.by_genre('party')
          ).to be_empty
        end
      end
    end
  end
end
