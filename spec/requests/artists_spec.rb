RSpec.describe "Artists endpoint", type: :request do

  before(:each) do
    @artists = create_list(:artist, 10)
  end

  describe "GET /api/v1/artists" do
    before { get '/api/v1/artists' }

    it "should return 200" do
      expect(response).to have_http_status(200)
    end

    it "should return all artists created" do
      payload = JSON.parse(response.body)
      expect(payload['data'].count).to eq(10)
    end
  end
end