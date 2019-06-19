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

class Album < ApplicationRecord
  default_scope { includes(:songs) }
  belongs_to :artist
  has_many :songs, dependent: :destroy
  validate :uniqueness_image_for_diferent_artists
  validates :image, :spotify_id, :spotify_url, :total_tracks, presence: true
  validates :spotify_id, :spotify_url, uniqueness: true

  private

  # def uniqueness_name_for_diferent_artists
  #   album = Album.find_by(name: name)
  #   errors.add(:name, 'name must be unique between artists') if album &&
  #                                                              album.artist_id != artist_id
  # end

  def uniqueness_image_for_diferent_artists
    album = Album.find_by(image: image)
    errors.add(:image, 'image must be unique between artists') if album &&
                                                               album.artist_id != artist_id
  end
end
