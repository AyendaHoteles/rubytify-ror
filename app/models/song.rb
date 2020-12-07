# == Schema Information
#
# Table name: songs
#
#  id          :integer          not null, primary key
#  name        :string
#  spotify_url :text
#  preview_url :text
#  duration_ms :integer
#  explicit    :boolean
#  spotify_id  :text
#  album       :references
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Song < ApplicationRecord
  belongs_to :albums
  validates_presence_of :name, :spotify_url :preview_url, :duration_ms, :explicit, spotify_id
  def self.new_from_spotify_song(spotify_song)
    Song.new(
      spotify_id: spotify_song.id,
      name: spotify_song.name,
      artists: spotify_song.artists[0].name,
      image: spotify_song.album.images[0]["url"],
      preview: spotify_song.preview_url
    )
end
