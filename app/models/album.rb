# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  name         :string
#  image        :text
#  spotify_url  :text
#  total_tracks :integer
#  spotify_id   :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Album < ApplicationRecord
  has_many :songs
  belongs_to :artists
  validates_presence_of :name, :spotify_url, :total_tracks, :spotify_id
end
