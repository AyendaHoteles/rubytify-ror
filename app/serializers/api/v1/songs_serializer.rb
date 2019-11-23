module Api
	module V1
		class SongsSerializer < ActiveModel::Serializer
  		attributes :id, :name, :spotify_url, :preview_url, :duration_ms, :explicit
		end
	end
end
