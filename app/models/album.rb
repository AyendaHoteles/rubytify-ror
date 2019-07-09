# == Schema Information
#
# Table name: albums
#
#  id           :bigint(8)        not null, primary key
#  artist_id    :bigint(8)
#  name         :string
#  image        :string
#  spotify_url  :string
#  total_tracks :integer
#  spotify_id   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_albums_on_artist_id  (artist_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#

class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs

  validates :spotify_id, uniqueness: true, presence: true
  validates :spotify_url, uniqueness: true, presence: true
  validates :artist_id, presence: true
  validates :name, presence: true
end
