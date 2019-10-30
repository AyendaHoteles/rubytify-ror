class Api::V1::GenresController < ApplicationController
	def random_song

		selected_songs=[]
		
		Artist.all.each do |artist|
			puts artist.genres.grep(/#{params[:genre_name]}/).present?
			if artist.genres.grep(/#{params[:genre_name]}/).present?
				artist.albums.each do |album|
				selected_songs << album.songs
				end
			end
		end
		puts selected_songs.shuffle.first
		@chosen_song=selected_songs.shuffle.first
	    @chosen = {"data" => @chosen_song.sample}
	    render json: @chosen.to_json(:except => [:created_at, :updated_at, :spotify_id, :album_id, :id])
	end
end
