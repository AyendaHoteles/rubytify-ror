module Api
	module V1
		class SongsController < ApplicationController
			def index
				album = Album.find(album_id)
				byebug
			end

			def album_id
				@album_id ||= params["album_id"]
			end
		end
	end
end
