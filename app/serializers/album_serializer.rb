class AlbumSerializer < ActiveModel::Serializer
  attributes :spotify_id, :name, :image, :spotify_url, :total_tracks
end
