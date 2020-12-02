# == Schema Information
#
# Table name: songs
#
#  id          :integer          not null, primary key
#  name        :string
#  spotify_url :text
#  preview_url :text
#  duration_ms :string
#  explicit    :boolean
#  spotify_id  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class SongTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
