# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  image        :string
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :integer
#

require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
