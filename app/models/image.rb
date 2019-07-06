# frozen_string_literal: true

# Image class
#
# NOTES:
#
# - Owners are polymorphic so any other class could have image(s).
class Image < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
