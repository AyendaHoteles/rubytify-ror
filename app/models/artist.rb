# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :text
#  popularity  :integer
#  spotify_url :text
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Artist < ApplicationRecord
    has_many :albums
    has_and_belongs_to_many :genres
    validates_presence_of :name, :image, :popularity, :spotify_url, :spotify_id
end
