class AlbumSerializer < ActiveModel::Serializer
  attributes attributes :id, :name, :image, :spotify_url, :total_tracks
end
