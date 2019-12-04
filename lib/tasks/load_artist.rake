desc "Crear base de datos con artistas, albumes y canciones"
#cargar yml con lista de artistas
task :subir_artists => :environment do
  RSpotify.authenticate("e26196c67053444d931da5cec4ac1526", "ab2b0bd4b0ee4674ae4b76914fce75e2")
  require 'yaml'
  file = YAML.load_file(File.join(Rails.root,'config', 'artistlist.yml'))
  file["artists"].each do |f|
     @artist = RSpotify::Artist.search("#{f}").first
     #guardar artistas
     Artist.create_from_spotify_artist(@artist)
   end 
    @albums = []
    @songs  = []
    @artist = Artist.all
    @artist.each do |s_artist|
        @albums  << RSpotify::Album.search(s_artist.name)       
    end
     @albums.each do |s_album|
     #guardar albumes
        s_album.each do |s|
        Album.create_from_spotify_album(s) 
        @songs  << RSpotify::Track.search(s.name)
       end 
    end
    #guardar canciones
     @songs.each do |s_songs|
      s_songs.each do |f|
       Song.create_from_spotify_song(f)
       end
     end
end