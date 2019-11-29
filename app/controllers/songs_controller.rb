class SongsController < ApplicationController
  before_action :exists_genre, only: [:random_song]
  before_action :exists_album, only: [:index]

  def index
    if params[:album_id]
      @songs = Album.find(params[:album_id]).songs
    else
      @songs = Song.all
    end

    render json: custom_parser( @songs )
  end

  def random_song
    puts 'Por aqui pasa'    
    name = params[:genre_name]
    genre = Genre.find_by(name: name)
    artist = List.find_by(genre_id: genre.id).artist
    album = artist.albums[ rand(0..(artist.albums.size-1)) ]
    @song = album.songs[ rand(0..(album.songs.size-1)) ]

    render json: custom_parser( @song )
  end

  private 
    def exists_genre
      render json: {"message":"The ".concat( params[:genre_name] ).concat( " genre does not exist." )}, 
      status: :bad_request if Genre.find_by(name: params[:genre_name]).nil?
    end

    def exists_album
      render json: {"message":"The album with id ".concat( params[:album_id] ).concat( " does not exist." )}, 
      status: :bad_request if Album.find_by(id: params[:album_id]).nil? and not params[:album_id].nil?
    end
end
