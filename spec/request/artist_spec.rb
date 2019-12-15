require "rails_helper"

RSpec.describe "Artist", type: :request do
    describe "whit data in db" do
        before { get '/api/v1/artists' }
        let(:artist) { create_list(:artist, 10) }

        it "shoud return all artists in db" do
            payload = JSON.parse(response.body) 
            expect(response).to have_http_status(200)
        end
    end
end