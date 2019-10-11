require "rails_helper"

RSpec.describe Api::V1::ArtistsController do
  context "On artists enpoint" do
    before(:each) do
      request.env["HTTP_ACCEPT"] = "application/json"
    end

    describe "index" do
      before do
        @artist = create(:artist)
        @album = create(:album)
        @song = create(:song)
        @genre = create(:genre)
        get :index
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    describe "show" do
      before do
        @artist = create(:artist)
        get :show, params: {id: @artist.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
