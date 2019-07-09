require "rails_helper"

RSpec.describe Api::V1::ArtistsController, type: :controller do
  describe "#index" do
    before do
      5.times { create(:artist) }
      get(:index, format: :json)
      @artists = JSON.parse(response.body)["data"]
    end

    it { expect(response).to have_http_status(200) }

    it "returns all countries" do
      expect(@artists.size).to eq(5)
    end

    it "returns correctly specific data" do
      first_artist = Artist.first

      artist_responsed = @artists.first
      expect(artist_responsed["id"]).to eq(first_artist.id)
      expect(artist_responsed["name"]).to eq(first_artist.name)
      expect(artist_responsed["genres"]).to eq(first_artist.genres)
      expect(artist_responsed["popularity"]).to eq(first_artist.popularity)
      expect(artist_responsed["spotify_url"]).to eq(first_artist.spotify_url)
      expect(artist_responsed["spotify_id"]).to eq(first_artist.spotify_id)
      expect(artist_responsed["image"]).to eq(first_artist.image)
    end
  end
end
