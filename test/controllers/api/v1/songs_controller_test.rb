require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  test "index action should be sucess" do
    get '/api/v1/albums/1/songs'
    assert_response 200
  end
end
