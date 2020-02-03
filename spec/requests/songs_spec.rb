RSpec.describe "Songs endpoint", type: :request do
  before(:each) do
    @album = create :album
    @songs = create_list(:song, 10, album_id: @album.id)
  end

  describe "GET /api/v1/artists/:id/songs" do
    before { get "/api/v1/albums/#{@album.id}/songs" }

    it "should return 200" do
      expect(response).to have_http_status(200)
    end

    it "should return all songs of an album" do
      payload = JSON.parse(response.body)
      expect(payload['data'].count).to eq(10)
    end
  end
end