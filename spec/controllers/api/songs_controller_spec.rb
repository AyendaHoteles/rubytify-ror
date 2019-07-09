require "rails_helper"

RSpec.describe Api::V1::SongsController, type: :controller do

  before :each do
    @artist = create(:artist)
    @album = create(:album, artist: @artist)
    5.times { create(:song, artist: @artist, album: @album) }
  end
  describe "#index" do
    before do
      params = { id: @album.id, format: :json }
      get(:index, params: params)
      @songs = JSON.parse(response.body)["data"]
    end

    it { expect(response).to have_http_status(200) }

    it "returns all albums" do
      expect(@songs.size).to eq(5)
    end

    it "returns correctly specific data" do
      first_song = Song.first
      song_responsed = @songs.first
      expect(song_responsed["id"]).to eq(first_song.id)
      expect(song_responsed["name"]).to eq(first_song.name)
      expect(song_responsed["spotify_url"]).to eq(first_song.spotify_url)
      expect(song_responsed["preview_url"]).to eq(first_song.preview_url)
      expect(song_responsed["spotify_id"]).to eq(first_song.spotify_id)
      expect(song_responsed["duration_ms"]).to eq(first_song.duration_ms)
      expect(song_responsed["explicit"]).to eq(first_song.explicit)
    end
  end

  describe "#random_song" do
    before do
      @artist2 = create(:artist, genres: ['genre1', 'genre2'])
      @album2 = create(:album, artist: @artist2)
      3.times { create(:song, artist: @artist2, album: @album2) }
      @genre = @artist2.genres.sample
      params = { genre_name: @genre, format: :json }
      get(:random_song, params: params)
      @song = JSON.parse(response.body)["data"]
      @random_song = Song.find_by(spotify_id: @song["spotify_id"])
    end

    it { expect(response).to have_http_status(200) }

    it "the songs belongs to the genre consulted" do
      expect(@random_song.artist.genres.include?(@genre)).to eq(true)
    end

    it "returns correctly specific data" do
      expect(@song["id"]).to eq(@random_song.id)
      expect(@song["name"]).to eq(@random_song.name)
      expect(@song["spotify_url"]).to eq(@random_song.spotify_url)
      expect(@song["preview_url"]).to eq(@random_song.preview_url)
      expect(@song["spotify_id"]).to eq(@random_song.spotify_id)
      expect(@song["duration_ms"]).to eq(@random_song.duration_ms)
      expect(@song["explicit"]).to eq(@random_song.explicit)
    end
  end
end
