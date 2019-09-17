class Gender < ApplicationRecord
  has_many :songs, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :artists, through: :relations, dependent: :destroy
  validates_presence_of :name
end
