require 'test_helper'

class Api::V1::SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_songs_index_url
    assert_response :success
  end

end
