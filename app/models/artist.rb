# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :text
#  genres      :text
#  popularity  :integer
#  spotify_url :text
#  spotify_id  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums
  validates_presence_of :name, :genres, :popularity, :spotify_url, :spotify_id
end
