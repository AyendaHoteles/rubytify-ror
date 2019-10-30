class Api::V1::ArtistsController < ApplicationController
	def index
	    @artists = {"data" => Artist.all.order(popularity: :desc)}
	    render json: @artists.to_json(:except => [:created_at, :updated_at, :spotify_id])
	end

	def albums_index
	    @albums = {"data" => Artist.find(params[:id]).albums}
	    render json: @albums.to_json(:except => [:created_at, :updated_at, :spotify_id, :artist_id])
	end
end
