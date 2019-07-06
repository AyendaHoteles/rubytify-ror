# frozen_string_literal: true

# Album class
#
# NOTES:
#
# - Belongs to an artist.
# - Has images.
class Album < ApplicationRecord
  belongs_to :artist
  has_many :images, as: :owner, dependent: :destroy
end
