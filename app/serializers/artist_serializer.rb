# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  genres      :text
#  popularity  :string
#  spotify_url :text
#  spotify_id  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :text
#

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :genres, :popularity, :spotify_url, :spotify_id, :image
end
