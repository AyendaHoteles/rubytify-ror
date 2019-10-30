class Api::V1::AlbumsController < ApplicationController
	def songs_index
	    @songs = {"data" => Album.find(params[:id]).songs}
	    render json: @songs.to_json(:except => [:created_at, :updated_at, :spotify_id, :album_id, :id])
	end
end
