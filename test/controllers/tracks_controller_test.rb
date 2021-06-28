require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @track = tracks(:one)
  end

  test "should get index" do
    get tracks_url, as: :json
    assert_response :success
  end

  test "should create track" do
    assert_difference('Track.count') do
      post tracks_url, params: { track: { duration_ms: @track.duration_ms, explicit: @track.explicit, genres: @track.genres, name: @track.name, preview_url: @track.preview_url, spotify_id: @track.spotify_id, spotify_id_album: @track.spotify_id_album, spotify_url: @track.spotify_url } }, as: :json
    end

    assert_response 201
  end

  test "should show track" do
    get track_url(@track), as: :json
    assert_response :success
  end

  test "should update track" do
    patch track_url(@track), params: { track: { duration_ms: @track.duration_ms, explicit: @track.explicit, genres: @track.genres, name: @track.name, preview_url: @track.preview_url, spotify_id: @track.spotify_id, spotify_id_album: @track.spotify_id_album, spotify_url: @track.spotify_url } }, as: :json
    assert_response 200
  end

  test "should destroy track" do
    assert_difference('Track.count', -1) do
      delete track_url(@track), as: :json
    end

    assert_response 204
  end
end
