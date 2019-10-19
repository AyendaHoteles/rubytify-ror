class Song < ApplicationRecord
  belongs_to :album

  validates_presence_of :name
end
