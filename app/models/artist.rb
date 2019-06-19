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

class Artist < ApplicationRecord
  has_and_belongs_to_many :genres
  default_scope { includes(:albums).order(popularity: :desc) }
  before_save { self.name = name&.downcase }
  serialize :genres, Array
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums
  validates :name, :image, :popularity, :spotify_url, :spotify_id, presence: true
  validates :name, :image, :spotify_url, :spotify_id, uniqueness: true
end
