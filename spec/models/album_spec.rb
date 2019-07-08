# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_one(:image).dependent(:destroy) }
    it { is_expected.to have_many(:songs).dependent(:destroy) }
  end

  describe 'callbacks' do
    let(:artist) { Artist.create! }
    let(:album) { Album.create!(artist: artist) }

    it 'fires delete_cache method as before_update method callbacks' do
      expect(album).to receive(:delete_cache).and_call_original
      album.run_callbacks(:update)
    end

    it 'fires delete_cache method as before_destroy method callbacks' do
      expect(album).to receive(:delete_cache).and_call_original
      album.run_callbacks(:destroy)
    end
  end
end
