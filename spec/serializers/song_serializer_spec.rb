# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SongSerializer do
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

  let!(:song) do
    Song.create!(
      name: 'hey',
      spotify_url: 'http://open.spotify.com/songs/hey',
      preview_url: 'http://open.spotify.com/songs/previews/hey',
      duration_ms: 10_000,
      explicit: false,
      album: album
    )
  end

  let!(:song_serializer) do
    SongSerializer.new(song)
  end

  describe '#as_json' do
    it 'returns selected properties only' do
      expect(song_serializer.as_json).to eq(
        'name' => 'hey',
        'spotify_url' => 'http://open.spotify.com/songs/hey',
        'preview_url' => 'http://open.spotify.com/songs/previews/hey',
        'duration_ms' => 10_000,
        'explicit' => false
      )
    end
  end
end
