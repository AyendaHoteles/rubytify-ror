class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :total_tracks, :spotify_url
end
