class Api::V1::GenresController < ApplicationController
  def sample
    match_artists = Artist.where("genres LIKE ?", "%#{params[:genre_name]}%") #Find all artists with that genre match
    if !match_artists.empty?
      albums = Album.where(artist_id: match_artists.sample) #Fetch all albums from one random artist
      sample_song = Song.where(album_id: albums.sample).sample #Fetch one random song from one random album
      render json: {data: sample_song},except:[:created_at,:updated_at, :album_id, :id, :spotify_id], status: :ok
    else
      render json: {data: "Could not find that genre, make sure you entered it correctly"}, status: :not_found
    end
  end
end
