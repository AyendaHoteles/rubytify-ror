namespace :importer do
  #Run this task like 'rake importer:populate'
  desc "Importer responsible of populating the database"
  task populate: :environment do
    puts "Clearing Database..."
    Rake::Task["db:reset"].invoke
    puts "Database cleared!"
    puts "Loading artists..."
    artists_yml = YAML.load_file(Rails.root + "db/data/artists.yml")
    artists_list = artists_yml["artists"]
    artists_list.each do |artist|
      artist_search_results = RSpotify::Artist.search(artist.to_s)
      #Creating the artist_______________________
      current_artist = artist_search_results.first
      new_artist = Artist.create!(
        name: current_artist.name,
        image: current_artist.images.sample["url"],
        genres: current_artist.genres,
        popularity: current_artist.popularity,
        spotify_url: current_artist.href,
        spotify_id: current_artist.id
      )
      #Creating the albums_______________________
      albums = current_artist.albums
      albums.uniq! {|album| album.name} #uniq! to avoid as many duplicates as possible and improving efficiency
      albums.each do |album|
        new_album = Album.create!(
          name: album.name,
          artist: new_artist,
          image: album.images.first["url"],
          spotify_url: album.href,
          total_tracks: album.tracks.length,
          spotify_id: album.id
        )
        #Creating the songs______________________
        songs = album.tracks
        songs.each do |song|
          new_song = Song.create!(
            name: song.name,
            album: new_album,
            spotify_url: song.href,
            preview_url: song.preview_url,
            duration_ms: song.duration_ms,
            explicit: song.explicit,
            spotify_id: song.id
          )
        end
      end
      puts "#{current_artist.name} Created!"
    end
    puts "Database successfully populated!"
        # artists = RSpotify::Artist.search('Arctic Monkeys')
        # arctic_monkeys = artists.first
        # albums = arctic_monkeys.albums
        # tracks = albums.first.tracks
        #puts arctic_monkeys.inspect
        # puts arctic_monkeys.name, arctic_monkeys.images.sample["url"], arctic_monkeys.genres,
        # arctic_monkeys.popularity, arctic_monkeys.href, arctic_monkeys.id
        #puts albums.inspect
        # puts tracks.first.explicit
  end
end
