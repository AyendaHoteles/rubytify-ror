class SongsController < ApplicationController
 
  def index
    if params[:album_id]
      @songs = Album.find(params[:album_id]).songs
    else
      @songs = Song.all
    end

    render json: custom_parser( @songs )
  end

  def random_song
    name = params[:genre_name]
    genre = Genre.find_by(name: name)
    artist = List.find_by(genre_id: genre.id).artist
    album = artist.albums[ rand(0..(artist.albums.size-1)) ]
    @song = album.songs[ rand(0..(album.songs.size-1)) ]

    render json: custom_parser( @song )
  end
end
