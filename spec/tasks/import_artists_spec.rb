require "rails_helper"
require "pathname"
require "webmock/rspec"

describe "rake import", type: :task do
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
    stub_config_file(nil)
    expect(File).to receive(:read).with(config_file_path)
    stub_auth
    task.execute
  end

  it "clears artists, songs, and albums tables before importing" do
    stub_auth
    stub_config_file(nil)
    task.execute
    expect(Artist.count).to eq(0)
    expect(Album.count).to eq(0)
    expect(Song.count).to eq(0)
  end

  it "searches the Spotify API with an artist name read from the YAML file" do
    artist_name = "name"
    stub_config_file(artist_name)

    empty_response = { artists: { items: [], total: 0 } }.to_json
    search_stub = stub_search_artist(artist_name).
      to_return(body: empty_response, status: 200)

    stub_auth
    task.execute
    expect(search_stub).to have_been_requested
  end

  it "creates an Artist, Albums, and Songs with the data returned by Spotify" do
    stub_search_artist(artist_1.name).to_return({ body: artist_1 })
    stub_request("https://api.spotify.com/v1/albums/#{artist_1.id}").
      to_return({ body: album_1 })
    stub_request("https://api.spotify.com/v1/tracks/#{album_1.id}").
      to_return({ body: song_1 })
    stub_auth
    task.execute
  end

  it "searches other artists when one is not found in Spotify" do
    stub_auth
    not_found_name = "not_found"
    stub_config_file(not_found_name, artist_1.name)
    stub_search_artist(not_found_name).to_return(not_found_error)
    stub_search_artist(artist_1.name).to_return(artist_1)
    task.execute
    expect(Artist.count).to eq(1)
    expect(Artist.first.name).to eq(artist_1.name)
  end

  it "retries a request when Spotify returns with 'Too many requests' error" do
    stub_auth
    stub_search_artist(artist_1.name).
      to_return(too_many_requests, { body: artist_1 })
    stub_search_artist(artist_2.name).to_return({ body: artist_2 })
    stub_request("https://api.spotify.com/v1/albums/#{artist_1.id}").
      to_return(too_many_requests, { body: album_1 })
    stub_request("https://api.spotify.com/v1/albums/#{artist_2.id}").
      to_return({ body: album_2 })
    stub_request("https://api.spotify.com/v1/tracks/#{album_1.id}").
      to_return(too_many_requests, { body: song_1 })
    stub_request("https://api.spotify.com/v1/tracks/#{album_2.id}").
      to_return({ body: song_2 })
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

  def stub_config_file(artist_name)
    data = "artists:\n"
    if artist_name
      data += "  - #{artist_name}\n"
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
      with(query: hash_including({"q" => artist_name, "type" => "artist" }))
  end
end
