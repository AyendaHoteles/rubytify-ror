require "rails_helper"

RSpec.describe Api::V1::AlbumsController, type: :controller do
  describe "#index" do
    before do
      artist = create(:artist)
      5.times { create(:album, artist: artist) }
      params = { artist_id: artist.id, format: :json }
      get(:index, params: params)
      @albums = JSON.parse(response.body)["data"]
    end

    it { expect(response).to have_http_status(200) }

    it "returns all albums" do
      expect(@albums.size).to eq(5)
    end

    it "returns correctly specific data" do
      first_album = Album.first

      album_responsed = @albums.first
      expect(album_responsed["id"]).to eq(first_album.id)
      expect(album_responsed["name"]).to eq(first_album.name)
      expect(album_responsed["spotify_url"]).to eq(first_album.spotify_url)
      expect(album_responsed["total_tracks"]).to eq(first_album.total_tracks)
      expect(album_responsed["spotify_id"]).to eq(first_album.spotify_id)
      expect(album_responsed["image"]).to eq(first_album.image)
    end
  end
end
