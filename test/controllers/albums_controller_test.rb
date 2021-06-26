require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @album = albums(:one)
  end

  test "should get index" do
    get albums_url, as: :json
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post albums_url, params: { album: { image: @album.image, name: @album.name, spotify_id: @album.spotify_id, spotify_id_artist: @album.spotify_id_artist, spotify_url: @album.spotify_url, total_tracks: @album.total_tracks } }, as: :json
    end

    assert_response 201
  end

  test "should show album" do
    get album_url(@album), as: :json
    assert_response :success
  end

  test "should update album" do
    patch album_url(@album), params: { album: { image: @album.image, name: @album.name, spotify_id: @album.spotify_id, spotify_id_artist: @album.spotify_id_artist, spotify_url: @album.spotify_url, total_tracks: @album.total_tracks } }, as: :json
    assert_response 200
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete album_url(@album), as: :json
    end

    assert_response 204
  end
end
