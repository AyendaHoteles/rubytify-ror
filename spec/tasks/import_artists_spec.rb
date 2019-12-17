require "rails_helper"
require "pathname"
require "webmock/rspec"

describe "rake import", type: :task do
  let!(:artist_1) { build(:artist) }
  let!(:artist_2) { build(:artist) }
  let!(:album_1)  { build(:album, artist: artist_1) }
  let!(:album_2)  { build(:album, artist: artist_2) }
  let!(:song_1)   { build(:song, album: album_1) }
  let!(:song_2)   { build(:song, album: album_2) }

  too_many_requests = Proc.new do
    {
      body:
        {
          error: {
            status: 429,
            message: "Too Many Requests - Rate limiting has been applied.",
          },
        }.to_json,
      status: 429,
      headers: { "Retry-After" => 0 },
    }
  end

  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  config_file_path = Pathname.new("#{Rails.root}/config/artist_names.yml")

  describe "Config YAML file with artist names exists" do
    subject { config_file_path }

    it { should exist }
    it { should be_file }
  end

  it "loads the YAML file with artist names" do
    stub_config_file([])
    expect(File).to receive(:read).with(config_file_path)
    stub_auth
    task.execute
  end

  it "clears artists, songs, and albums tables before importing" do
    create_list(:artist, 10)
    create_list(:album, 10)
    create_list(:song, 10)
    stub_config_file([])

    stub_auth
    task.execute

    expect(Artist.count).to eq(0)
    expect(Album.count).to eq(0)
    expect(Song.count).to eq(0)
  end

  it "searches the Spotify API with an artist name read from the YAML file" do
    artist_name = "name"
    stub_config_file([artist_name])

    empty_response = { artists: { items: [], total: 0 } }.to_json
    search_stub = stub_search_artist(artist_name).
      to_return(body: empty_response, status: 200)

    stub_auth
    task.execute
    expect(search_stub).to have_been_requested
  end

  it "creates an Artist, Albums, and Songs with the data returned by Spotify" do
    stub_search_artist(artist_1.name).
      to_return(body: artist_payload(artist_1).to_json)
    stub_request(:get, "https://api.spotify.com/v1/artists/#{artist_1.spotify_id}/albums").
      to_return(body: albums_payload(album_1).to_json)
    stub_request(:get, "https://api.spotify.com/v1/albums/#{album_1.spotify_id}/tracks").
      to_return(body: songs_payload(song_1).to_json)

    stub_config_file([artist_1.name])
    stub_auth
    task.execute

    expect(Artist.count).to eq(1)
    artist = Artist.first
    expect(artist.name).to eq(artist_1.name)
    expect(artist.image).to eq(artist_1.image)
    expect(artist.genres).to eq(artist_1.genres)
    expect(artist.popularity).to eq(artist_1.popularity)
    expect(artist.spotify_url).to eq(artist_1.spotify_url)
    expect(artist.spotify_id).to eq(artist_1.spotify_id)

    expect(Album.count).to eq(1)
    album = Album.first
    expect(album.name).to eq(album_1.name)
    expect(album.image).to eq(album_1.image)
    expect(album.total_tracks).to eq(album_1.total_tracks)
    expect(album.spotify_url).to eq(album_1.spotify_url)
    expect(album.spotify_id).to eq(album_1.spotify_id)

    expect(Song.count).to eq(1)
    song = Song.first
    expect(song.name).to eq(song_1.name)
    expect(song.preview_url).to eq(song_1.preview_url)
    expect(song.duration_ms).to eq(song_1.duration_ms)
    expect(song.explicit).to eq(song_1.explicit)
    expect(song.spotify_url).to eq(song_1.spotify_url)
    expect(song.spotify_id).to eq(song_1.spotify_id)
  end

  it "searches other artists when one is not found in Spotify" do
    not_found_name = "not_found"
    stub_search_artist(not_found_name).
      to_return(body: empty_artist_payload.to_json)
    stub_search_artist(artist_1.name).
      to_return(body: artist_payload(artist_1).to_json)
    stub_request(:get, "https://api.spotify.com/v1/artists/#{artist_1.spotify_id}/albums").
      to_return(body: albums_payload(album_1).to_json)
    stub_request(:get, "https://api.spotify.com/v1/albums/#{album_1.spotify_id}/tracks").
      to_return(body: songs_payload(song_1).to_json)

    stub_config_file([not_found_name, artist_1.name])
    stub_auth
    task.execute

    expect(Artist.count).to eq(1)
    expect(Artist.first.name).to eq(artist_1.name)
  end

  it "retries a request when Spotify returns with 'Too many requests' error" do
    stub_search_artist(artist_1.name).
      to_return(too_many_requests,
                { body: artist_payload(artist_1).to_json })
    stub_search_artist(artist_2.name).
      to_return(body: artist_payload(artist_2).to_json)

    stub_request(:get, "https://api.spotify.com/v1/artists/#{artist_1.spotify_id}/albums").
      to_return(too_many_requests,
                { body: albums_payload(album_1).to_json })
    stub_request(:get, "https://api.spotify.com/v1/artists/#{artist_2.spotify_id}/albums").
      to_return(body: albums_payload(album_2).to_json)

    stub_request(:get, "https://api.spotify.com/v1/albums/#{album_1.spotify_id}/tracks").
      to_return(too_many_requests,
                { body: songs_payload(song_1).to_json })
    stub_request(:get, "https://api.spotify.com/v1/albums/#{album_2.spotify_id}/tracks").
      to_return(body: songs_payload(song_2).to_json)

    stub_config_file([artist_1.name, artist_2.name])
    stub_auth
    task.execute

    expect(Artist.count).to eq(2)
    expect(Artist.first.name).to eq(artist_1.name)
    expect(Artist.last.name).to eq(artist_2.name)
    expect(Album.count).to eq(2)
    expect(Album.first.name).to eq(album_1.name)
    expect(Album.last.name).to eq(album_2.name)
    expect(Song.count).to eq(2)
    expect(Song.first.name).to eq(song_1.name)
    expect(Song.last.name).to eq(song_2.name)
  end

  private

  def stub_config_file(artist_names)
    data = "artists:\n"
    artist_names.each do |artist_name|
      if artist_name
        data += "  - #{artist_name}\n"
      end
    end
    allow(File).to receive(:read).and_return(data)
  end

  def stub_auth
    access_token = {
      access_token: "a_token",
      token_type: "bearer",
      expires_in: 3600,
    }.to_json

    stub_request(:post, "https://accounts.spotify.com/api/token").
      with(body: { "grant_type" => "client_credentials" }).
      to_return(body: access_token, status: 200)
  end

  def stub_search_artist(artist_name)
    stub_request(:get, "https://api.spotify.com/v1/search").
      with(query: hash_including({ "q" => artist_name, "type" => "artist" }))
  end

  def empty_artist_payload
    {
      "artists": {
        "href": "https://api.spotify.com/v1/search?query=dsffdsfd&type=artist",
        "items": [],
        "limit": 20,
        "next": nil,
        "offset": 0,
        "previous": nil,
        "total": 0,
      },
    }
  end

  def artist_payload(artist)
    {
      "artists": {
        "href": "https://api.spotify.com/v1/search?query=#{artist.name}&type=artist",
        "items": [
          {
            "external_urls": {
              "spotify": artist.spotify_url,
            },
            "genres": artist.genres,
            "href": "https://api.spotify.com/v1/artists/#{artist.spotify_id}",
            "id": artist.spotify_id,
            "images": [
              {
                "height": 640,
                "url": artist.image,
                "width": 640,
              },
              {
                "height": 300,
                "url": "https://i.scdn.co/image/b414091165ea0f4172089c2fc67bb35aa37cfc55",
                "width": 300,
              },
              {
                "height": 64,
                "url": "https://i.scdn.co/image/8522fc78be4bf4e83fea8e67bb742e7d3dfe21b4",
                "width": 64,
              },
            ],
            "name": artist.name,
            "popularity": artist.popularity,
            "type": "artist",
            "uri": "spotify:artist:#{artist.spotify_id}",
          },
        ],
        "limit": 20,
        "next": nil,
        "offset": 0,
        "previous": nil,
        "total": 1,
      },
    }
  end

  def albums_payload(album)
    {
      "href": "https://api.spotify.com/v1/artists/#{album.artist.spotify_id}/albums",
      "items": [
        {
          "album_group": "appears_on",
          "album_type": "album",
          "artists": [
            {
              "external_urls": {
                "spotify": album.artist.spotify_url,
              },
              "href": "https://api.spotify.com/v1/artists/#{album.artist.spotify_id}",
              "id": album.artist.spotify_id,
              "name": "Various Artists",
              "type": "artist",
              "uri": "spotify:artist:#{album.artist.spotify_id}",
            },
          ],
          "available_markets": [
            "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CH", "CL", "CO",
            "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR",
            "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IL", "IS", "IT",
            "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MY", "NI", "NL", "NO",
            "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "RO", "SE", "SG", "SK",
            "SV", "TH", "TR", "TW", "UY", "VN", "ZA",
          ],
          "external_urls": {
            "spotify": album.spotify_url,
          },
          "href": "https://api.spotify.com/v1/albums/#{album.spotify_id}",
          "id": album.spotify_id,
          "images": [
            {
              "height": 640,
              "url": album.image,
              "width": 640,
            },
            {
              "height": 300,
              "url": "https://i.scdn.co/image/29368267cc6b1eab2600e6e42485d3774621e7d4",
              "width": 300,
            },
            {
              "height": 64,
              "url": "https://i.scdn.co/image/779dd6d6a0e124e03a5143d2be729ee4bab3f15f",
              "width": 64,
            },
          ],
          "name": album.name,
          "release_date": "2018-02-09",
          "release_date_precision": "day",
          "type": "album",
          "uri": "spotify:album:#{album.spotify_id}",
        },
      ],
      "limit": 1,
      "next": "https://api.spotify.com/v1/artists/1vCWHaC5f2uS3yhpwWbIA6/albums",
      "offset": 0,
      "previous": nil,
      "total": 308,
    }
  end

  def songs_payload(song)
    {
      "href": "https://api.spotify.com/v1/albums/#{song.album.spotify_id}/tracks",
      "items": [{
        "artists": [{
          "external_urls": {
            "spotify": song.album.artist.spotify_url,
          },
          "href": "https://api.spotify.com/v1/artists/#{song.album.artist.spotify_url}",
          "id": song.album.artist.spotify_url,
          "name": "Tania Bowra",
          "type": "artist",
          "uri": "spotify:artist:#{song.album.artist.spotify_url}",
        }],
        "available_markets": [
          "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO",
          "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB",
          "GR", "GT", "HK", "HN", "HU", "IE", "IS", "IT", "LI", "LT", "LU", "LV",
          "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL",
          "PT", "PY", "RO", "SE", "SG", "SI", "SK", "SV", "TR", "TW", "US", "UY",
        ],
        "disc_number": 1,
        "duration_ms": song.duration_ms,
        "explicit": song.explicit,
        "external_urls": {
          "spotify": song.spotify_url,
        },
        "href": "https://api.spotify.com/v1/tracks/#{song.spotify_id}",
        "id": song.spotify_id,
        "name": song.name,
        "preview_url": song.preview_url,
        "track_number": 1,
        "type": "track",
        "uri": "spotify:track:#{song.spotify_id}",
      }],
      "limit": 1,
      "next": "https://api.spotify.com/v1/albums/#{song.album.spotify_id}/tracks",
      "offset": 0,
      "previous": nil,
      "total": 11,
    }
  end
end
