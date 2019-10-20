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
#  spotify_id  :string
#  album_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Song < ApplicationRecord
  belongs_to :album
end
