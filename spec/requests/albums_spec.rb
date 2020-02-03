RSpec.describe "Albums endpoint", type: :request do
  before(:each) do
    @artist = create :artist
    @albums = create_list(:album, 10, artist_id: @artist.id)
  end

  describe "GET /api/v1/artists/:id/albums" do
    before { get "/api/v1/artists/#{@artist.id}/albums" }

    it "should return 200" do
      expect(response).to have_http_status(200)
    end

    it "should return all albums associated" do
      payload = JSON.parse(response.body)
      expect(payload['data'].count).to eq(10)
    end
  end
end