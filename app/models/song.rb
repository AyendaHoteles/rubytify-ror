class Song < ApplicationRecord
  serialize(:genres, Array)
end
