# == Schema Information
#
# Table name: songs
#
#  id          :bigint           not null, primary key
#  duration_ms :integer
#  explicit    :boolean
#  name        :string
#  preview_url :string
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  album_id    :integer
#  genre_id    :integer
#

require 'test_helper'

class SongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
