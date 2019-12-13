class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_url, :total_tracks

  #belongs_to :artist, serializer: ArtistSerializer
end
