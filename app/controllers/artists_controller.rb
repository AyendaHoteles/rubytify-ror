class ArtistsController < ApplicationController
    
    def index
        artists = Artist.all.order('popularity DESC')
        render json: { data: serialize_artists(artists) }, status: :ok
        # render json: { data: @artists.as_json(except: [:spotify_id, :created_at, :updated_at], 
        #                include: :genres )}, status: :ok
    end

    def albums
        begin
            artist = Artist.find(params[:id])
            render json: { data: artist.albums.as_json(except: 
                        [:created_at, :updated_at, :spotify_id, :artist_id]) }, status: :ok
        rescue => exception
            render json: {error: "artist does not exist"}, status: 404   
        end
    end
end
