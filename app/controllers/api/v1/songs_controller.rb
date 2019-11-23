module Api
	module V1
		class SongsController < ApplicationController
			def index
				album = Album.find(album_id)

				render json: album.songs, 
								each_serializer: Api::V1::SongsSerializer, 
								root: 'data', 
								status: :ok
			end

			def random_song
				song = Song.joins(album: :artist)
										.where!(":name = ANY(artists.genres)", name: genre_name)
										.sample

				render json: song, 
										serializer: Api::V1::SongsSerializer, 
										root: 'data', status: :ok
			end

			protected

			def album_id
				@album_id ||= params["album_id"]
			end

			def genre_name
				@genre_name ||= params["genre_name"]
			end
		end
	end
end
