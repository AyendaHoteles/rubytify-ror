# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlbumSerializer do
  let!(:artist) do
    Artist.create!(
      name: 'Tom',
      genres: %w[party electro],
      popularity: 80,
      spotify_url: 'http://open.spotify.com/artists/tom'
    )
  end

  let!(:album) do
    Album.create!(
      name: 'Moiz',
      total_tracks: 10,
      spotify_url: 'http://open.spotify.com/albums/moiz',
      artist: artist
    )
  end

  let!(:image) do
    Image.create!(
      height: 10,
      width: 10,
      url: 'http://open.spotify.com/images/moiz',
      owner: album
    )
  end

  let!(:album_serializer) do
    AlbumSerializer.new(album)
  end

  describe '#as_json' do
    it 'returns selected properties only' do
      expect(album_serializer.as_json).to eq(
        'id' => album.id,
        'name' => 'Moiz',
        'spotify_url' => 'http://open.spotify.com/albums/moiz',
        'total_tracks' => 10,
        'image' => {
          'width' => 10,
          'height' => 10,
          'url' => 'http://open.spotify.com/images/moiz'
        }
      )
    end
  end
end
