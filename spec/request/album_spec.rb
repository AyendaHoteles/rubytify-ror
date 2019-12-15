require "rails_helper"

RSpec.describe "Album", type: :request do
    describe "GET /api/v1/albums/{:album_id}/songs" do
        let(:album) { create_list(:album, 10) }

        it "shoud return post" do
            get "/api/v1/albums/#{album.first.id}/songs"

            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(response).to have_http_status(200)
        end
     
     end
end 