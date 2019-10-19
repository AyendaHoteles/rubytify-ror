# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  name         :string
#  image        :text
#  spotify_url  :text
#  total_tracks :integer
#  spotify_id   :string
#  artist_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Album < ApplicationRecord
  belongs_to :artist
  validates_presence_of :name, :image, :spotify_url, :total_tracks, :spotify_id, :artist_id
end
