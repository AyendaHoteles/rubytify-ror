require 'rspotify'

task :import => :environment do
    puts "Cleaning the database"
    Song.destroy_all
    Album.destroy_all
    Artist.destroy_all

    RSpotify.authenticate("1870d19b854c43eeb9b230c409dde8ab", "2e58dc05201f48acba33d01f17c8824f")
    
    artist_names = YAML::load(File.read(Rails.root.join('config/artist_names.yml')))["artists"]
    artist_names.each do |artist_name|
        artist_name = artist_name.to_s
        puts artist_name
        results = RSpotify::Artist.search(artist_name, limit: 1)
        if results.total == 0 then
            puts "Artist not found!"
            next
        end

        artist_data = results.first
        artist = Artist.new
        artist.name        = artist_data.name;
        artist.image       = artist_data.images.first["url"]
        artist.genres      = artist_data.genres.join('|')
        artist.popularity  = artist_data.popularity
        artist.spotify_url = artist_data.external_urls["spotify"]
        artist.spotify_id  = artist_data.uri.delete_prefix! "spotify:artist:"
        artist.save!

        artist_data.albums.each do |album_data|
            puts "\t #{album_data.name} - #{album_data.uri}"
            album = artist.albums.create!(
                name:         album_data.name,
                image:        album_data.images.first["url"],
                total_tracks: album_data.total_tracks,
                spotify_url:  album_data.external_urls["spotify"],
                spotify_id:   album_data.uri.delete_prefix!("spotify:album:")
            )

            album_data.tracks.each do |song_data|
                puts "\t\t #{song_data.name} - #{song_data.uri}"
                song = album.songs.create!(
                    name:        song_data.name,
                    preview_url: song_data.preview_url,
                    duration_ms: song_data.duration_ms,
                    explicit:    song_data.explicit,
                    spotify_url: song_data.external_urls["spotify"],
                    spotify_id:  song_data.uri.delete_prefix!("spotify:track:")
                )
            end
        end
    end
end