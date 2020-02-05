# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :albums, dependent: :delete_all
  has_many :songs, through: :albums
  validates_presence_of :name, :image, :genres, :popularity, :spotify_url, :spotify_id

  def search_genre(genre)
    JSON.parse(genres).include?(genre)
  end

  def self.possible_genres
    all.pluck(:genres).map do |genre|
      JSON.parse(genre)
    end
  end

  def self.sample
    all.sample
  end
end
