require 'test_helper'

class Api::V1::ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_artists_index_url
    assert_response :success
  end

end
