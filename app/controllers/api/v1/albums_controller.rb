module Api
	module V1
		class AlbumsController < ApplicationController
			def index
				artist = Artist.find(artist_id)

				render json: artist.albums, 
								each_serializer: Api::V1::AlbumsSerializer, 
								root: 'data', status: :ok
			end

			protected

			def artist_id
				@artist_id ||= params["artist_id"]
			end
		end
	end
end
