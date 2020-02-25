# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs

  validates :name,
            :image,
            :spotify_url,
            :spotify_id, presence: true
end
