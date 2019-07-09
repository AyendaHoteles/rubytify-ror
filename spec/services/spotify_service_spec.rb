require "rails_helper"
require 'json'

RSpec.describe SpotifyService do
  let(:artist) { create(:empty_artist, name: 'J Balvin') }
  let(:service) { described_class.new }
  #lo ideal es hacer un mock de la respuesta del client, pero para afectos
  #practicos llamo la api solo una vez pues es un objeto anidado
  #con varias clases.
  let(:data_response) { SpotifyClient.new.get_artist_data('J Balvin')}

  describe "#update_artist" do
    before do
      service.update_artist(data_response, artist)
    end

    it "update_artist" do
      expect(artist.genres).not_to eq(nil)
      expect(artist.popularity).not_to eq(nil)
      expect(artist.spotify_url).not_to eq(nil)
      expect(artist.spotify_id).not_to eq(nil)
      expect(artist.image).not_to eq(nil)
    end
  end

  describe "#create_albums and create_songs" do
    before do
      @album = data_response.albums.first
      service.create_albums(artist, [@album])
    end

    it "create albums and songs" do
      expect(artist.albums.count).to eq(1)
      expect(artist.albums.first.songs.count).to eq(@album.tracks.count)
    end
  end
end
