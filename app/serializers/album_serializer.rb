class AlbumSerializer < ActiveModel::Serializer
  attributes :name, :image, :spotify_url, :total_tracks, :spotify_id
end
