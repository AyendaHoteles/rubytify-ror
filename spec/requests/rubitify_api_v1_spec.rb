require 'rails_helper'

RSpec.describe "RubitifyApiV1", type: :request do
  describe "with empty db" do
    describe "GET /api/v1/artists" do
      it "returns OK" do
        get "/api/v1/artists"
        expect_success
        expect(payload[:data]).to be_empty
      end
    end

    describe "GET /api/v1/artists/:id/albums" do
      it "returns OK" do
        get "/api/v1/artists/123/albums"
        expect_success
        expect(payload[:data]).to be_empty
      end
    end

    describe "GET /api/v1/albums/:id/songs" do
      it "returns OK" do
        get "/api/v1/albums/123/songs"
        expect_success
        expect(payload[:data]).to be_empty
      end
    end

    describe "GET /api/v1/genres/:genre_name/random_song" do
      it "returns OK" do
        get "/api/v1/genres/none/random_song"
        expect_success
        expect(payload[:data]).to be_empty
      end
    end
  end

  describe "with multiple items in db" do
    let!(:artists) { create_list(:artist, 3) }
    let!(:albums)  { create_list(:album, 4, artist: artists[0]) }
    let!(:songs)   { create_list(:song, 10, album: albums[0]) }

    describe "GET /api/v1/artists" do
      it "returns all artists ordered by their popularity" do
        get "/api/v1/artists"
        expect_success
        ret_artists = payload[:data]
        sorted_artist_popularities = artists.map(&:popularity).sort { |a, b| b <=> a }
        ret_popularities = ret_artists.map { |artist| artist[:popularity] }

        expect(payload).not_to be_empty
        expect(ret_artists.size).to eq(artists.size)
        expect(ret_popularities).to eq(sorted_artist_popularities)
      end
    end

    describe "GET /api/v1/artists/:id/albums" do
      it "returns all albums from given artist" do
        get "/api/v1/artists/#{artists[0].id}/albums"
        expect_success
        expect(payload).not_to be_empty
        expect(payload[:data].size).to eq(albums.size)
      end
    end

    describe "GET /api/v1/albums/:id/songs" do
      it "returns all songs in given album" do
        get "/api/v1/albums/#{albums[0].id}/songs"
        expect_success
        expect(payload).not_to be_empty
        expect(payload[:data].size).to eq(songs.size)
      end
    end

    describe "GET /api/v1/genres/:genre_name/random_song" do
      it "returns a song that matches the specified genre" do
        # TODO(Jhovan) actually test randomness?
        get "/api/v1/genres/#{artists[0].genres[0]}/random_song"
        expect_success
        ret_song = payload[:data][0]

        expect(payload).not_to be_empty
        expect(payload[:data].size).to eq(1)

        expect(ret_song).to include(:name)
        expect(ret_song).to include(:explicit)
        expect(ret_song).to include(:preview_url)
        expect(ret_song).to include(:spotify_url)
        expect(ret_song).to include(:duration_ms)

        expect(ret_song).not_to include(:id)
        expect(ret_song).not_to include(:spotify_id)
        expect(ret_song).not_to include(:album_id)
        expect(ret_song).not_to include(:created_at)
        expect(ret_song).not_to include(:updated_at)
      end
    end
  end

  describe "OK with single item in db" do
    let!(:artist) { create(:artist) }
    let!(:album)  { create(:album, artist: artist) }
    let!(:song)   { create(:song, album: album) }

    describe "GET /api/v1/artists" do
      it "returns desired fields" do
        get "/api/v1/artists"
        expect_success
        ret_artist = payload[:data][0]

        expect(ret_artist[:id]).to          eq(artist.id)
        expect(ret_artist[:name]).to        eq(artist.name)
        expect(ret_artist[:image]).to       eq(artist.image)
        expect(ret_artist[:genres]).to      eq(artist.genres)
        expect(ret_artist[:popularity]).to  eq(artist.popularity)
        expect(ret_artist[:spotify_url]).to eq(artist.spotify_url)

        expect(ret_artist[:genres]).not_to be_empty

        expect(ret_artist).not_to include(:spotify_id)
        expect(ret_artist).not_to include(:created_at)
        expect(ret_artist).not_to include(:updated_at)
      end
    end

    describe "GET /api/v1/artists/:id/albums" do
      it "returns desired fields" do
        get "/api/v1/artists/#{artist.id}/albums"
        expect_success
        ret_album = payload[:data][0]

        expect(ret_album[:id]).to           eq(album.id)
        expect(ret_album[:name]).to         eq(album.name)
        expect(ret_album[:image]).to        eq(album.image)
        expect(ret_album[:spotify_url]).to  eq(album.spotify_url)
        expect(ret_album[:total_tracks]).to eq(album.total_tracks)

        expect(ret_album).not_to include(:spotify_id)
        expect(ret_album).not_to include(:artist_id)
        expect(ret_album).not_to include(:created_at)
        expect(ret_album).not_to include(:updated_at)
      end
    end

    describe "GET /api/v1/albums/:id/songs" do
      it "returns desired fields" do
        get "/api/v1/albums/#{album.id}/songs"
        expect_success
        ret_song = payload[:data][0]

        expect(ret_song[:name]).to        eq(song.name)
        expect(ret_song[:explicit]).to    eq(song.explicit)
        expect(ret_song[:preview_url]).to eq(song.preview_url)
        expect(ret_song[:spotify_url]).to eq(song.spotify_url)
        expect(ret_song[:duration_ms]).to eq(song.duration_ms)

        expect(ret_song).not_to include(:id)
        expect(ret_song).not_to include(:spotify_id)
        expect(ret_song).not_to include(:album_id)
        expect(ret_song).not_to include(:created_at)
        expect(ret_song).not_to include(:updated_at)
      end
    end
  end

  private

  def payload
    JSON.parse(response.body).with_indifferent_access
  end

  def expect_success
    expect(payload).to include(:data)
    expect(response).to be_successful
    expect(response).to have_http_status(:ok)
  end
end
