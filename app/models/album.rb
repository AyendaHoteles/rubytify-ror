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

class Album < ApplicationRecord
  validates_uniqueness_of :name, :spotify_id
  belongs_to :artist
  has_many :songs
  serialize :image
end
