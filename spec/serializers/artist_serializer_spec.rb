# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtistSerializer do
  let!(:artist) do
    Artist.create!(
      name: 'Tom',
      genres: %w[party electro],
      popularity: 80,
      spotify_url: 'http://open.spotify.com/artists/tom'
    )
  end

  let!(:image) do
    Image.create!(
      height: 10,
      width: 10,
      url: 'http://open.spotify.com/images/tom',
      owner: artist
    )
  end

  let!(:artist_serializer) do
    ArtistSerializer.new(artist)
  end

  describe '#as_json' do
    it 'returns selected properties only' do
      expect(artist_serializer.as_json).to eq(
        'id' => artist.id,
        'genres' => %w[party electro],
        'name' => 'Tom',
        'popularity' => 80,
        'spotify_url' => 'http://open.spotify.com/artists/tom',
        'image' => {
          'height' => 10,
          'width' => 10,
          'url' => 'http://open.spotify.com/images/tom'
        }
      )
    end
  end
end
