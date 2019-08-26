class Artist < ApplicationRecord
  has_many :albums

  validates_uniqueness_of :name
end
