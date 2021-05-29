namespace :info_spotify do
   desc "Read the list of artists from the artist.yml file and search the information of each one from spotify"
   task getData: :environment do
      load_artists
   end

   def load_artists
      f_artists = YAML.load(File.read("./config/artists.yml"))
      
      f_artists['artists'].each do |s_artist|
         spotify_artists = RSpotify::Artist.search(s_artist.to_s)
         
         spotify_artist = spotify_artists.first
         artist = Artist.create_from_spotify_artist(spotify_artist)
            
         spotify_artist.albums.map do |spotify_album|
            album = Album.create_from_spotify_album(artist.id, spotify_album)
            
            spotify_album.tracks.map do |spotify_song|
               Song.create_from_spotify_song(album.id, spotify_song)
            end
         end
      end
   end
end
