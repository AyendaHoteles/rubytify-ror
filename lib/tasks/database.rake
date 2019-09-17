namespace :database do

  desc "Save changes on database"
  task create: :environment do

    def create_artist(a)
      artist = RSpotify::Artist.search(a.to_s).first
      if artist != nil && Artist.where(name: artist.name).empty?
        new_artist = Artist.create(name: artist.name, image: artist.images[0]["url"], popularity: artist.popularity , spotify_url: artist.external_urls["spotify"], spotify_id: artist.id)
        create_genders(artist, new_artist)
      end
    end

    def create_genders(artist, new_artist)
      if artist.genres.empty? == false
        artist.genres.each do |g|
          if Gender.where(name: g).empty?
            # crea el genero si no existe ya
            new_gender = Gender.create(name: g)
            new_artist.genders << new_gender
          else
            # sino, lo encuentro para saber que enviarle a news_genders
            new_gender = Gender.find_by(name: g)
            new_artist.genders << new_gender
          end
        end
      end
      create_albums(artist, new_artist)
    end

    def create_albums(artist, new_artist)
      if artist.albums.empty? == false
        # crea los albums si el artista tiene
        artist.albums.each do |a|
          # crea el albúm
          new_album = Album.create(name: a.name, image: a.images[0]["url"], spotify_url: a.external_urls["spotify"], total_tracks: a.total_tracks, spotify_id: a.id, artist_id: new_artist.id)
          # crealas canciones de ese album
          a.tracks.each do |s|
            #le asigna a cada cancion un genero de ese mismo artista aleatorio
            genresong = new_artist.genders.sample.id
            new_song = Song.create(name: s.name, spotify_url: s.external_urls["spotify"], preview_url: s.preview_url, duration_ms: s.duration_ms, explicit: s.explicit, spotify_id: s.id, album_id: new_album.id , gender_id: genresong)
          end
        end
      end
    end

    list_artist = YAML.load_file('config/create_db.yml')
    list_artist["artists"].each do |a|
      create_artist(a)
    end

  end
end
