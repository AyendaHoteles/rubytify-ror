require 'rails_helper'

RSpec.describe "RubitifyApiV1", type: :request do
  describe "with empty db" do
    describe "GET /api/v1/artists" do
      it "returns OK" do
        get "/api/v1/artists"
        expect(payload).to include(:data)
        expect(payload[:data]).to be_empty
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET /api/v1/artists/:id/albums" do
      it "returns OK" do
        get "/api/v1/artists/123/albums"
        expect(payload).to include(:data)
        expect(payload[:data]).to be_empty
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET /api/v1/albums/:id/songs" do
      it "returns OK" do
        get "/api/v1/albums/123/songs"
        expect(payload).to include(:data)
        expect(payload[:data]).to be_empty
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET /api/v1/genres/:genre_name/random_song" do
      it "returns OK" do
        get "/api/v1/genres/none/random_song"
        expect(payload).to include(:data)
        expect(payload[:data]).to be_empty
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  private

  def payload
    JSON.parse(response.body).with_indifferent_access
  end
end
