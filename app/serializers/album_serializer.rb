# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  artist_id    :integer
#  name         :string
#  spotify_url  :text
#  total_tracks :integer
#  spotify_id   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :text
#

class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_url, :total_tracks, :spotify_id
end
