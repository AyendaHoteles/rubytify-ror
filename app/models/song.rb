class Song < ApplicationRecord
  belongs_to :album, optional: true
end
