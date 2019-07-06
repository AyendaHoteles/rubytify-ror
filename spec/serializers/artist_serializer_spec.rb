# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtistSerializer do
  let(:artist_serializer) { ArtistSerializer.new(Artist.new) }

  describe '#as_json' do
    it 'returns selected properties only' do
      expect(artist_serializer.as_json).to eq(
        {
          'id' => nil,
          'genres' => [],
          'name' => nil,
          'popularity' => nil,
          'spotify_url' => nil
        }
      )
    end
  end
end
