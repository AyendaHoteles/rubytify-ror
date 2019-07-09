# == Schema Information
#
# Table name: artists
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  image       :string
#  genres      :string
#  popularity  :integer
#  spotify_url :string
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Artist < ApplicationRecord
  has_many :albums
  has_many :songs

  validates :spotify_id, uniqueness: true, presence: true
  validates :spotify_url, uniqueness: true, presence: true
  validates :name, presence: true
end
