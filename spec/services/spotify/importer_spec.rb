# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spotify::Importer, :vcr do
  let(:artists_names) do
    YAML
      .load_file('spec/fixtures/artists.yml')['artists']
      .map(&:to_s)
  end

  describe '.call' do
    it 'imports artists' do
      expect do
        Spotify::Importer.call(artists_names)
      end.to change { Artist.count }.by(1)
    end

    it 'imports artists-images' do
      expectation = expect do
        Spotify::Importer.call(artists_names)
      end
      expectation.to change { Image.where(owner_type: 'Artist').count }.by(1)
    end

    it 'imports albums' do
      expect do
        Spotify::Importer.call(artists_names)
      end.to change { Album.count }.by(50)
    end
  end

  describe '.search_spotify_artists' do
    it 'search artists by name' do
      expect(Spotify::Importer.search_spotify_artists(['Area21']).size).to eq(1)
    end
  end

  describe '.create_artist' do
    let(:spotify_artist) do
      OpenStruct.new(
        name: 'Mike',
        genres: %w[pop],
        popularity: 80,
        href: 'http://open.spotify.com/artists/mike',
        id: 'mike',
        images: [
          {
            url: 'http://open.spotify.com/images/mike',
            width: 10,
            height: 10
          }
        ]
      )
    end

    it 'returns an artist with image' do
      expect(
        Spotify::Importer.create_artist(spotify_artist)
      ).to have_attributes(
        id: a_value > 0,
        name: 'Mike',
        genres: %w[pop],
        popularity: 80,
        spotify_url: 'http://open.spotify.com/artists/mike',
        spotify_identifier: 'mike',
        image: be_an_instance_of(Image)
      )
    end

    it 'creates an artist with image' do
      expect do
        Spotify::Importer.create_artist(spotify_artist)
      end.to change { Artist.count }.by(1) && change { Image.count }.by(1)
    end
  end

  describe '.create_album' do
    let(:artist) { Artist.create! }

    let(:spotify_album) do
      OpenStruct.new(
        name: 'Rao',
        total_tracks: 70,
        href: 'http://open.spotify.com/albums/rao',
        id: 'rao',
        images: [
          {
            url: 'http://open.spotify.com/images/rao',
            width: 10,
            height: 10
          }
        ]
      )
    end

    it 'returns an album with image' do
      expect(
        Spotify::Importer.create_album(artist, spotify_album)
      ).to have_attributes(
        id: a_value > 0,
        name: 'Rao',
        total_tracks: 70,
        spotify_url: 'http://open.spotify.com/albums/rao',
        spotify_identifier: 'rao',
        image: be_an_instance_of(Image)
      )
    end

    it 'creates an album and image' do
      expect do
        Spotify::Importer.create_album(artist, spotify_album)
      end.to change { Album.count }.by(1)
    end
  end

  describe '.create_song' do
    let(:artist) { Artist.create! }

    let(:album) { Album.create!(artist: artist) }

    let(:spotify_song) do
      OpenStruct.new(
        name: 'Yulo',
        explicit: false,
        duration_ms: 2000,
        preview_url: 'http://open.spotify.com/previews/yulo',
        href: 'http://open.spotify.com/songs/yulo',
        id: 'yulo'
      )
    end

    it 'returns an song' do
      expect(
        Spotify::Importer.create_song(album, spotify_song)
      ).to have_attributes(
        id: a_value > 0,
        name: 'Yulo',
        explicit: false,
        duration_ms: 2000,
        preview_url: 'http://open.spotify.com/previews/yulo',
        spotify_url: 'http://open.spotify.com/songs/yulo',
        spotify_identifier: 'yulo'
      )
    end

    it 'creates a song' do
      expect do
        Spotify::Importer.create_song(album, spotify_song)
      end.to change { Song.count }.by(1)
    end
  end
end
