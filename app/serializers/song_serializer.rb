# frozen_string_literal: true

# == Schema Information
#
# Table name: songs
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  spotify_url :string
#  preview_url :string
#  duration_ms :integer
#  explicit    :boolean
#  spotify_id  :string
#  album_id    :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SongSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :spotify_url,
             :preview_url,
             :duration_ms,
             :explicit,
             :spotify_id
end
