# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :text
#  popularity  :integer
#  spotify_url :text
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :popularity, :spotify_url
end
