require "rails_helper"

RSpec.describe Api::V1::AlbumsController do
  context "On albums enpoints request" do
    describe "index" do
      before do
        get :index, format: :json
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
