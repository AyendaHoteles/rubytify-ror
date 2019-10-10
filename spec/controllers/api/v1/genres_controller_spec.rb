require "rails_helper"

RSpec.describe Api::V1::GenresController do
  context "On genres enpoint" do
    before(:each) do
      @genre = create(:genre)
      request.env["HTTP_ACCEPT"] = "application/json"
    end

    describe "index" do
      before do
        get :index
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
    describe "show" do
      before do
        get :show, params: {id: @genre.name.capitalize}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns data array" do
        expect(response.body).to include("data")
      end
    end

    describe "random" do
      before do
        get :random, params: {id: @genre.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
