# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  image       :string
#  genres      :string
#  popularity  :integer
#  spotify_url :string
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArtistSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :image,
             :popularity,
             :spotify_url,
             :genres

  def genres
    object.genres&.map(&:name)
  end
end
