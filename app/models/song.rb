# frozen_string_literal: true

# Song class
#
# NOTES:
#
# - Belongs to an album.
class Song < ApplicationRecord
  belongs_to :album
end
