class Api::V1::ArtistsController < ApplicationController
  
  def index
    show_artists
  end

  def show
    show_album
  end

  private
    def show_artists
      object_artists = []
      @artists = Artist.all.order(popularity: :desc)
      @artists.each do |a|
        genre_artist = RSpotify::Artist.search(a.name.to_s).first.genres
        new_object = { id: a.id, name: a.name ,image: a.image ,genres: genre_artist, popularity: a.popularity, spotify_url: a.spotify_url }
        object_artists.push(new_object)
      end
      render json: { data: object_artists }
    end

    def show_album
      new_album = []
      albums = Album.where(artist_id: params[:id])
      albums.each do |album|
        al = { id: album.id, name: album.name ,image: album.image, spotify_url: album.spotify_url, total_tracks: album.total_tracks }
        new_album.push(al)
      end
      render json: { data: new_album }
    end

end
