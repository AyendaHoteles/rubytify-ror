# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  image        :string
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :integer
#

class Album < ApplicationRecord
  belongs_to :artist
  has_many   :songs

  validates :name, :spotify_url, presence: true
end
