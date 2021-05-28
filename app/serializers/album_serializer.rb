class AlbumSerializer < ActiveModel::Serializer
   attributes :id, :name, :image, :spotify_url, :total_tracks, :spotify_id
end
