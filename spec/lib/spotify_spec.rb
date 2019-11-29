require "spec_helper"
require "rails_helper"
require_relative '../../lib/modules/ayenda_request.rb'
require_relative '../../lib/constants/spotify_constants.rb'
include AyendaRequest
include SpotifyConstants

describe "Spotify" do
    before :all do
        @artistJson = {
            "genres": [
              "garage rock",
              "modern rock",
              "permanent wave",
              "rock",
              "sheffield indie"
            ],
            "href": "https://api.spotify.com/v1/artists/7Ln80lUS6He07XvHI8qqHH",
            "id": "7Ln80lUS6He07XvHI8qqHH",
            "images": [
              {
                "url": "https://i.scdn.co/image/ed0552e9746ed2bbf04ae4bcb5525700ca31522d",
              }
            ],
            "name": "Arctic Monkeys",
            "popularity": 85,
        }
        @albumJson = {
            "href": "https://api.spotify.com/v1/albums/2PVMhulhCDsV67jZsvkqc6",
            "id": "2PVMhulhCDsV67jZsvkqc6",
            "images": [
              {
                "height": 640,
                "url": "https://i.scdn.co/image/ab67616d0000b273a31824505d9c862727b625d8",
                "width": 640
              },
            ],
            "name": "Soma25",
            "total_tracks": 20,
          }
        @songJson = {
            "disc_number": 1,
            "duration_ms": 354640,
            "explicit": false,
            "href": "https://api.spotify.com/v1/tracks/0FgNSsaSZTvbLXUumSO8LQ",
            "id": "0FgNSsaSZTvbLXUumSO8LQ",
            "name": "Star Treatment",
            "preview_url": "https://p.scdn.co/mp3-preview/96cf115e9813becf7d7d39f80fcc6a929666858f?cid=39d777ada6d5449f899e5ba7c895aa9e",
            "track_number": 1,
        }
        @mockArtistsNames = ["artist_0","artist_1"]
        @mockAlbumsNames = ["album_1","album_2"]
        @mockSongNames = ["song_1","song_2","song_3"]

        @responseArtists = {"artists":{"items":[]}}
        @responseAlbums = {"items":[]}
        @responseSongs = {"items":[]}

       for i in 0..(@mockArtistsNames.length - 1) do
            artist = @artistJson
            artist[:name] = @mockArtistsNames[i]
            artist[:id] = SecureRandom.uuid

            @responseArtists[:artists][:items] << artist.as_json
        end
        @responseArtists = @responseArtists.as_json

        for i in 0..(@mockAlbumsNames.length - 1) do
            album = @albumJson
            album[:name] = @mockAlbumsNames[i]
            album[:id] = SecureRandom.uuid

            @responseAlbums[:items] << album.as_json
        end
        @responseAlbums = @responseAlbums.as_json

        for i in 0..(@mockSongNames.length - 1) do
            song = @songJson
            song[:name] = @mockSongNames[i]
            song[:id] = SecureRandom.uuid

            @responseSongs[:items] << song.as_json
        end
        @responseSongs = @responseSongs.as_json


    end

    before :each do
        allow( AyendaRequest ).to receive( :set_token ).and_return ( nil )
        @spotify = Spotify.new @mockArtistsNames
    end

    it "should set artist correctly" do
        #  GIVEN
        @mockArtistsNames.each do |name|
            allow( AyendaRequest ).to receive( :get_request )
                .with( SpotifyConstants.search_url.concat( "?type=artist&q=" ).concat( name ) )
                .and_return ( @responseArtists )
        end

        # WHEN
        @spotify.set_artists

        # THEN
        expect( @spotify.artists_ids.length ).to be( @responseArtists["artists"]["items"].length )
        expect( Artist.all.pluck(:spotify_id) ).to match_array( @responseArtists["artists"]["items"].pluck("id"))
    end

    it "should set albums correctly" do
        #  GIVEN
        @spotify.artists_ids = [1,2,3,4]
 
        @spotify.artists_ids.each do |art_id|
            allow( AyendaRequest ).to receive( :get_request )
                .with( SpotifyConstants.artists_url.concat( art_id ).concat("/albums") )
                .and_return ( @responseAlbums )
            allow( Artist ).to receive( :find_by! )
                .and_return( Artist.new )
        end
        
        # WHEN
        @spotify.set_albums

        # THEN
        expect( Album.all.length ).to be(  @mockAlbumsNames.length )
        expect( Album.all.pluck(:spotify_id) ).to match_array( @responseAlbums["items"].pluck("id"))
    end

    it "should set songs correctly" do
        #  GIVEN
        @spotify.albums_dictionary = {"1":["id_1"],"2":["id_2"]}
        
        @spotify.albums_dictionary.keys.each do | key |
            @spotify.albums_dictionary[ key ].each do | album |
                allow( AyendaRequest ).to receive( :get_request )
                    .with( SpotifyConstants.albums_url.concat( album ).concat("/tracks") )
                    .and_return ( @responseSongs )
                allow( Album ).to receive( :find_by! )
                    .and_return( Album.new )
            end
        end

        # WHEN
        @spotify.set_songs

        # THEN
        expect( Song.all.length ).to be(  @mockSongNames.length )
        expect( Song.all.pluck(:spotify_id) ).to match_array( @responseSongs["items"].pluck("id"))
    end
end
