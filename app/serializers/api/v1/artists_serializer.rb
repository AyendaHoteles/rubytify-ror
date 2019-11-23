module Api
	module V1
		class ArtistsSerializer < ActiveModel::Serializer
  		attributes :id, :name, :genres, :popularity, :spotify_url, :spotify_id
		end
	end
end

