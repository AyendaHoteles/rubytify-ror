# == Schema Information
#
# Table name: songs
#
#  id          :bigint(8)        not null, primary key
#  artist_id   :bigint(8)
#  album_id    :bigint(8)
#  name        :string
#  spotify_url :string
#  preview_url :string
#  duration_ms :integer
#  explicit    :boolean
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_songs_on_album_id   (album_id)
#  index_songs_on_artist_id  (artist_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#  fk_rails_...  (artist_id => artists.id)
#

class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album

  validates :spotify_id, uniqueness: true, presence: true
  validates :spotify_url, uniqueness: true, presence: true
  validates :artist_id, presence: true
  validates :album_id, presence: true
  validates :name, presence: true
end
