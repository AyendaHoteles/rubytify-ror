namespace :db do
  namespace :upload_data do
    desc 'Upload data'

    task create: :environment do
      artists = YAML.load_file(Rails.root.join('db', 'seeds', 'artists.yml')).values[0]

      artists.each do |name_artist|
        artist = RSpotify::Artist.search(name_artist.to_s, limit: 1)

        create_artist(artist.last) unless artist.empty?
      end
    end

    def create_artist(artist)
      puts ' * ' + artist.name
      artist_new = Artist.new(name: artist.name,
                              image: artist.images.last['url'],
                              genres: artist.genres,
                              popularity: artist.popularity,
                              spotify_url: artist.external_urls['spotify'],
                              spotify_id: spotify_id = artist.id)

      if artist_new.save
        Thread.new do
          Rails.application.executor.wrap do
            create_albuns(artist.albums, artist_new)
          end
        end
      end
    end

    def create_albuns(albuns, artist_new)
      albuns.each do |album|
        album_new = Album.new(name: album.name,
                              image: album.images.last['url'],
                              spotify_url: album.external_urls['spotify'],
                              total_tracks: album.total_tracks,
                              spotify_id: album.id,
                              artist: artist_new)
                              
        create_songs(album, album_new) if album_new.save
      end
    end

    def create_songs(album, album_new)
      album.tracks.each do |song|
        song = Song.create(name: song.name,
                    spotify_url: song.external_urls{:spotify},
                    preview_url: song.preview_url,
                    duration_ms: song.duration_ms,
                    explicit:    song.explicit,
                    spotify_id:  song.id,
                    album:       album_new)
      end
    end
  end
end
