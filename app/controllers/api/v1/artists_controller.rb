module Api
	module V1
		class ArtistsController < ApplicationController
			def index
				@artists = Artist.all
				
				render json: @artists, each_serializer: Api::V1::ArtistsSerializer, root: 'data', status: :ok
			end
		end
	end
end
