class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  validates_presence_of :name, :created_at
end
