class Song < ApplicationRecord
  belongs_to :album

  validates :name, presence: true
  validates :duration_ms, presence: true, numericality: {only_integer: true}
  validates :spotify_id, presence: true
  validates_associated :album
end
