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

class Song < ApplicationRecord
  belongs_to :album
  validates :name, :spotify_url, :preview_url, :duration_ms, :explicit, :spotify_id, presence: true, allow_blank: true
  validates :spotify_url, :spotify_id, uniqueness: true

  # def uniqueness_name_for_diferent_artists
  #   song = Song.find_by(name: name)
  #   errors.add(:name, 'name must be unique between artists') if song &&
  #                                                               song.album.artist_id != album.artist_id
  # end

  # Can be iquals preview_url in the same artist but not in different ones
  # def uniqueness_preview_for_diferent_artists
  #   song = Song.find_by(preview_url: preview_url)
  #   errors.add(:name, 'preview url must be unique between artists') if preview_url && song &&
  #                                                                      song.album.artist_id != album.artist_id
  # end
end
