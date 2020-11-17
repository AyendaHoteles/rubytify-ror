class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  accepts_nested_attributes_for :albums, reject_if: :all_blank, allow_destroy: true

  has_many :artist_genres,  dependent: :destroy
end
