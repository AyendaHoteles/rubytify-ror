namespace :database do

  desc "Save changes on database"
  task create: :environment do

    list_artist = YAML.load_file('config/locales/create_db.yml')
    list_artist["artists"].each do |a|
      artist = RSpotify::Artist.search(a.to_s).first
      if artist != nil && Artist.where(name: artist.name).empty?
        # Crea el artista si no existe y lo asigna la variable new_artist
        new_artist = Artist.create(name: artist.name, image: artist.images[0]["url"], popularity: artist.popularity , spotify_url: artist.external_urls["spotify"], spotify_id: artist.id)
        #si ela artista tiene generos los crea
        if artist.genres.empty? == false
          artist.genres.each do |g|
            # crea el genero sino existe
            if Gender.where(name: g).empty?
              Gender.create(name: g)
            end
          end
        end
        #si el artista tiene albumes lso guarda
        if artist.albums.empty? == false
         artist.albums.each do |a|
           #Crea y Guarda el album con artist id correspodiente
           new_album = Album.create(name: a.name, image: a.images[0]["url"], spotify_url: a.external_urls["spotify"], total_tracks: a.total_tracks, spotify_id: a.id, artist_id: new_artist.id)
           a.tracks.each do |t|
            #crea y guadra las canciones de ese album , asigna album_id correspodiente, y genre_id al primer genero del artista
             correct_gender =  Gender.find_by(name: artist.genres[0]).id
             new_song = Song.create(name: t.name, spotify_url: t.external_urls["spotify"], preview_url: t.preview_url, duration_ms: t.duration_ms, explicit: t.explicit, spotify_id: t.id, album_id: new_album.id , gender_id: correct_gender)
           end
         end
       end
     end
    end

   #termina la tarea
  end
end
