class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy

  accepts_nested_attributes_for :albums
end
