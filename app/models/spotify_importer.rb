class SpotifyImporter

    def initialize
      
    end

    artists_list["artists"].each do |artist|
        artist_info = RSpotify::Artist.search(artist.to_s).first
        if artist_info
            artist = create_artist(artist_info)
            create_artist_albums(artist_info.albums, artist)
        else
            puts "Artist #{artist} not found"
        end
    end
end