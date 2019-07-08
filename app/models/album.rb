# frozen_string_literal: true

# Album class
#
# NOTES:
#
# - Belongs to an artist.
# - Has one image.
# - Has songs.
class Album < ApplicationRecord
  belongs_to :artist
  has_one :image, as: :owner, dependent: :destroy, autosave: true
  has_many :songs, dependent: :destroy

  before_update :delete_cache
  before_destroy :delete_cache

  private

  def delete_cache
    Rails.cache.delete("album/#{id}")
  end
end
