# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RandomGenreService, type: :service do
  describe '#show' do
    context 'when receive a valid genre name' do
      let(:song) { create(:song) }

      it 'returns a Song' do
        artist = song.album.artist
        random = described_class.new(artist.genres.sample).show

        expect(random.name.present?).to eq true
        expect(random.spotify_id.present?).to eq true
      end
    end
  end
end
