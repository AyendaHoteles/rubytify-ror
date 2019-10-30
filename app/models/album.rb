# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  name         :string
#  image        :string
#  spotify_url  :string
#  total_tracks :integer
#  spotify_id   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Album < ApplicationRecord
	belongs_to :artist
	has_many :songs
end
