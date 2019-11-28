require 'rspotify'
module Spotify 
	extend ActiveSupport::Concern

  included do
    before_action :connection
  end

  def connection
    RSpotify.authenticate("835d1ed2842d46c2b90fc4d622673b2d", "748f666d3d174d5994e1a111bad70968")
  end

  def album
    connection
    albums = []
    artists = RSpotify::Artist.search('Arctic Monkeys')
    arctic_monkeys = artists.first.albums
    arctic_monkeys.each do |album|
      albums.push(album.name)
    end
    albums
  end

  def song
    songs = []
    album.each do |alb|
      albums = RSpotify::Album.search(alb)
      album_n = albums.first.tracks
      album_n.each do |song|
        songs.push(song.name)
      end
    end   
    songs
  end

#Queda faltando agregar generos
#Queda faltando editar tipos de datos
#probar pasando a seeds
  def save_info
    artists = ["Artic Monkeys","Metallica","Nirvana","Diomedes Diaz","AC/DC","311", "Calle 13","BTS","El ultimo de la fila","Atercipelados","Alci Acosta","Green Day","Tormenta","Chuck Berry", "Joe Cuba","Compay Segundo","Buena Vista Social Club","Masacre","Pantera","Ruben Blades","Los Hermanos Zuleta", "Carlos Vives","Muse"]

    artists.each do |artist|
      artist_search = RSpotify::Artist.search(artist).first
      artist_search_name = artist_search.name
      artist_search_image = artist_search.images.first
      artist_search_popularity = artist_search.popularity 
      artist_search_url = artist_search.uri
      artist_search_id = artist_search.id
      Artist.create({name: artist_search_name, image: artist_search_image, popularity: artist_search_popularity,spotify_url:  artist_search_url,spotify_id: artist_search_id })
      albums =  RSpotify::Artist.search(artist).first.albums
      albums.each do |album|
        album_search = RSpotify::Album.search(album)
        album_search_name = album_search.name
        album_search_image = album_search.images.first
        album_search_tracks = album_search.total_tracks
        album_search_url = album_search.uri
        album_search_id = album_search.id
        album_search_artist_id = Artist.last.id
        Album.create({name: album_search_name, image: album_search_image, spotify_url: album_search_url,total_tracks:  album_search_tracks,spotify_id: album_search_id, id_artist_id:  album_search_artist_id})
        songs = RSpotify::Album.search(album).tracks
        songs.each do |song|
          song_search = RSpotify::Track.search(song)
          song_search_name = song_search.name
          song_search_url = song_search.uri
          song_search_preview_url = song_search.preview_url
          song_search_duration = song_search.duration_ms
          song_search_explicit = song_search.explicit 
          song_search_id = song_search.id
          song_search_album_id = Album.last.id
          Song.create({name: song_search_name, spotify_url: song_search_url,preview_url: song_search_preview_url, duration_ms: song_search_duration,explicit: song_search_explicit, spotify_id:  song_search_id, id_album_id: song_search_album_id  })
        end
      end
    end

  end

end
