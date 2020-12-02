# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  name         :string
#  image        :text
#  spotify_url  :text
#  total_tracks :integer
#  spotify_id   :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
