# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :text
#  genres      :text
#  popularity  :integer
#  spotify_url :text
#  spotify_id  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
