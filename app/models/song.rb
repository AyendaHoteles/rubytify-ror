class Song < ApplicationRecord

def self.new_from_spotify_song(spotify_song)
    Song.new(

      name: spotify_song.name,
      spotify_url: spotify_song.external_urls,
      preview_url: spotify_song.preview_url,
      duration_ms: spotify_song.duration_ms,
      explicit: spotify_song.explicit,
      spotify_id: spotify_song.id
    )
 end
 #metodo para guardar canciones.
 def self.create_from_spotify_song(spotify_song)
    song = self.new_from_spotify_song(spotify_song)
    song.save
    song
  end
  
end
