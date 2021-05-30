class Song < ApplicationRecord
   belongs_to :album
   
   def self.new_from_spotify_song(album_id, spotify_song)
      Song.new(
         name: spotify_song.name,
         preview_url: spotify_song.preview_url,
         duration_ms: spotify_song.duration_ms,
         explicit: spotify_song.explicit ,
         spotify_url: spotify_song.external_urls['spotify'],
         spotify_id: spotify_song.id,
         album_id: album_id
      )
   end
   
   def self.create_from_spotify_song(album_id, spotify_song)
      unless self.exist_song(spotify_song.id)
         song = self.new_from_spotify_song(album_id, spotify_song)
         song.save
      song
   end
   
   def self.exist_song(spotify_id)
      song = Song.find_by(spotify_id: spotify_id)
      if song
         return true
      end
   end
end
