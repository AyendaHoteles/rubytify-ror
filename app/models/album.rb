class Album < ApplicationRecord
  serialize(:genres, Array)
end
