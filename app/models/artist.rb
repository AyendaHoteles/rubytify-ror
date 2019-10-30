# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :string
#  popularity  :integer
#  spotify_url :string
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  genres      :string
#

class Artist < ApplicationRecord
	serialize(:genres, Array)
	has_many :albums
end
