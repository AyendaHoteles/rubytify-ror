namespace :db do
  desc "Empty the db and populates with data from spotify API"
  task fetch_and_populate: :environment do
    # drop all databases
    Rake::Task['db:reset'].invoke

    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
    artists_yaml = YAML.load(File.read("artists.yml"))

    # populate db with artists from spotify API
    artists_yaml["artists"].each do |artist|
      artists = RSpotify::Artist.search(artist.to_s)
      artist_fetched = artists.first
      if artist_fetched
        artist = Artist.create({
          name: artist_fetched.name,
          image: artist_fetched.images[0]["url"],
          popularity: artist_fetched.popularity,
          spotify_url: artist_fetched.external_urls["spotify"],
          spotify_id: artist_fetched.id
        })
        artist.save!
      end
    end

    # populates albums table
    artists_db = Artist.all
    artists_db.each do |artist|
      res = RSpotify::Artist.find(artist.spotify_id)
      if res
        res.albums.each do |album|
          new_album = Album.create({
            name: album.name,
            image: album.images[0]["url"],
            spotify_url: album.external_urls["spotify"],
            total_tracks: album.total_tracks,
            spotify_id: album.id,
            artist_id: artist.id
          })
          new_album.save!
        end
      end
    end

    # populates songs table
    #  name        :string
    #  spotify_url :text
    #  preview_url :text
    #  duration_ms :integer
    #  explicit    :boolean
    #  spotify_id  :string
    #  album_id    :integer
    albums_db = Album.all 
    albums_db.each do |album|
      res = RSpotify::Album.find(album.spotify_id)
      if res
        res.tracks.each do |track|
          new_track = Song.create({
            name: track.name,
            spotify_url: track.external_urls["spotify"],
            preview_url: track.preview_url ? track.preview_url : 'not found',
            duration_ms: track.duration_ms ? track.duration_ms : 'not found',
            explicit: track.explicit ? track.explicit : false,
            spotify_id: track.id,
            album_id: album.id
          })
          new_track.save!
        end
      end
    end    
    
  end
end
