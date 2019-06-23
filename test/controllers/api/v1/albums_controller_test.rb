require 'test_helper'

class Api::V1::AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_albums_index_url
    assert_response :success
  end

end
