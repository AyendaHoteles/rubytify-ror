require "rails_helper"

RSpec.describe Api::V1::SongsController, type: :controller do

  before(:each) do
    artist = create(:artist)
    other_artist = create(:artist)
    @genre = create(:genre, artist_ids: artist.id)
    other_genre = create(:genre, artist_ids: other_artist.id)
    @album = create(:album, artist: artist)
    10.times { create(:song, album: @album) }
  end

  context 'songs#index' do
    before do
      get(:index, params: { id: @album.id})
    end

    it 'should the key to be data' do
      expect(JSON.parse(response.body)).to have_key('data')
    end

    it 'should valid keys' do
      song = JSON.parse(response.body)['data'][0]
      expect(song).to have_key('name')
      expect(song).to have_key('spotify_url')
      expect(song).to have_key('preview_url')
      expect(song).to have_key('duration_ms')
      expect(song).to have_key('explicit')
    end

    it 'should return valid code response' do
      expect(response.status).to eq(200)
    end

    it 'should return many songs' do
      expect(JSON.parse(response.body)['data'].count).to eq(10)
    end
  end

  context 'songs#random_song' do
    before do
      get(:random_song, params: {genre_name: @genre.name} )
      @song = JSON.parse(response.body)['data']
      @database_song = Song.where(spotify_url: @song['spotify_url']).last
    end

    it "the songs belongs to the genre consulted" do
      expect(@database_song.album.artist.genres.pluck(:name).include?(@genre.name)).to eq(true)
    end

    it 'should return valid code response' do
      expect(response.status).to eq(200)
    end

    it 'should valid keys' do
      expect(@song).to have_key('name')
      expect(@song).to have_key('spotify_url')
      expect(@song).to have_key('preview_url')
      expect(@song).to have_key('duration_ms')
      expect(@song).to have_key('explicit')
    end
  end

end
