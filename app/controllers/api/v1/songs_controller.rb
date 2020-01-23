class Api::V1::SongsController < ApplicationController
    # GET /genres/:genre_name/random_song
    def random_song
        @artist = Artist.where("genres LIKE ?", "%\"#{params[:genre_name]}\"%")
        @artist = @artist.sample
        @album = @artist.albums.sample.songs.sample
        render json: { data: @album }, except: [:spotify_id, :created_at, :updated_at, :album_id, :albums_id]
    end
end