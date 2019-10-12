# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  genres      :string
#  image       :string
#  name        :string
#  poputarity  :integer
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Artist < ApplicationRecord
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :songs
  has_many                :albums

  validates :name, :spotify_url, presence: true
end
