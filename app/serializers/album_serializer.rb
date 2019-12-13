class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :image, :name, :spotify_url, :total_tracks
end
