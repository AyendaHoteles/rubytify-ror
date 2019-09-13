class Gender < ApplicationRecord
  # model association
  has_many :songs, dependent: :destroy
  #validation
  validates_presence_of :name
end
