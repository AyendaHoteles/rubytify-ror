require "rspotify"

task :import => :environment do
  puts "Cleaning the database"
  Song.destroy_all
  Album.destroy_all
  Artist.destroy_all

  RSpotify.authenticate("1870d19b854c43eeb9b230c409dde8ab", "2e58dc05201f48acba33d01f17c8824f")
  artist_names = YAML.safe_load(File.read(Rails.root.join("config/artist_names.yml")))["artists"]
  artist_names.each do |artist_name|
    artist_name = artist_name.to_s
    puts artist_name
    results = RSpotify::Artist.search(artist_name, limit: 1)
    if results.total == 0
      puts "Artist not found!"
      next
    end

    artist_data = results.first
    artist = Artist.create!(
      name: artist_data.name,
      image: artist_data.images.first["url"],
      genres: artist_data.genres,
      popularity: artist_data.popularity,
      spotify_id: artist_data.uri.delete_prefix!("spotify:artist:"),
      spotify_url: artist_data.external_urls["spotify"],
    )

    artist_data.albums.each do |album_data|
      puts "** #{album_data.name} - #{album_data.uri}"
      album = artist.albums.create!(
        name: album_data.name,
        image: album_data.images.first["url"],
        spotify_id: album_data.uri.delete_prefix!("spotify:album:"),
        spotify_url: album_data.external_urls["spotify"],
        total_tracks: album_data.total_tracks,
      )

      album_data.tracks.each do |song_data|
        puts "**** #{song_data.name} - #{song_data.uri}"
        album.songs.create!(
          name: song_data.name,
          explicit: song_data.explicit,
          spotify_id: song_data.uri.delete_prefix!("spotify:track:"),
          preview_url: song_data.preview_url,
          duration_ms: song_data.duration_ms,
          spotify_url: song_data.external_urls["spotify"],
        )
      end
    end
  end
end
