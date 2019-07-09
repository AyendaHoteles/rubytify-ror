# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  genres      :text
#  popularity  :string
#  spotify_url :text
#  spotify_id  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :text
#

class Artist < ApplicationRecord
  serialize :genres
  has_many :albums
  has_many :songs
  serialize :image
  scope :get_artists_by_genre, -> (genre_name) { where(" genres LIKE '%#{genre_name}%'") }
end
