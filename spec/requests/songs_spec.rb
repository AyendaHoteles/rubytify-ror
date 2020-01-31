RSpec.describe "Songs endpoint", type: :request do
  describe "GET /api/v1/artists/:id/songs" do
    before { get '/api/v1/artists/:id/songs' }

    it "should return 200" do
      expect(response).to have_http_status(200)
    end
  end
end