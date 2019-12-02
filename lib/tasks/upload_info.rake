require 'rspotify'
require 'yaml'

def connection
  RSpotify.authenticate("835d1ed2842d46c2b90fc4d622673b2d", "748f666d3d174d5994e1a111bad70968")
end

def save_info
     
  connection

  artists_yml = YAML.load_file('artist.yml')
  artists = artists_yml['artists']

  artists.each do |artist|
    begin
      artist_search = RSpotify::Artist.search(artist).first
      artist_search_name = artist_search.name
      artist_search_image = artist_search.images.first['url']
      artist_search_genres = artist_search.genres
      artist_search_popularity = artist_search.popularity 
      artist_search_url = artist_search.external_urls['spotify']
      artist_search_id = artist_search.id


      Artist.create({name: artist_search_name, image: artist_search_image , genres: artist_search_genres , popularity: artist_search_popularity,spotify_url:  artist_search_url,spotify_id: artist_search_id })

      albums = artist_search.albums

    

      albums.each_with_index do |album|
        album_search = RSpotify::Album.search(album.name).first
        album_search_id = album_search.id

        album_is_save = Album.where(spotify_id: album_search_id)
        if album_is_save.empty?

          album_search_name = album_search.name
          album_search_image = album_search.images.first['url']
          album_search_tracks = album_search.total_tracks
          album_search_url = album_search.external_urls['spotify']
          album_search_artist_id = Artist.last.id


          Album.create({name: album_search_name,image: album_search_image,  spotify_url: album_search_url,total_tracks:  album_search_tracks,spotify_id: album_search_id, artist_id:  album_search_artist_id})

          songs = album_search.tracks

          songs.each do |song|
            song_search = RSpotify::Track.search(song.name).first
            song_search_name = song_search.name
            song_search_url = song_search.external_urls['spotify']
            song_search_preview_url = song_search.preview_url
            song_search_duration = song_search.duration_ms
            song_search_explicit = song_search.explicit 
            song_search_id = song_search.id
            song_search_album_id = Album.last.id

            Song.create({name: song_search_name, spotify_url: song_search_url,preview_url: song_search_preview_url, duration_ms: song_search_duration,explicit: song_search_explicit, spotify_id:  song_search_id, album_id: song_search_album_id  })
          end
        end
      end
    rescue Exception => e
      
    end
  end 
end

namespace :upload_info do
  desc "TODO"
  task upload: :environment do
    save_info
  end

end
