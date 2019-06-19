# frozen_string_literal: true

# == Schema Information
#
# Table name: albums
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  spotify_id   :string
#  image        :string
#  artist_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AlbumSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :image,
             :spotify_url,
             :total_tracks,
             :spotify_id
end
