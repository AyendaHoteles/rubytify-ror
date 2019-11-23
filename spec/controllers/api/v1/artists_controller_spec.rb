require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
	context 'succes request' do
    let!(:artist) { create(:artist) }
		let(:request_response_body) do
        JSON.parse(response.body)
    end

		it "should returns correct params of the artists" do
		  get :index

		  expect(response.status).to eq 200
		  expect(request_response_body.last["popularity"]).to eq(artist.popularity)
		  expect(request_response_body.last["name"]).to eq(artist.name)
		  expect(request_response_body.last).to match_json_schema('artist')
		end
	end
end
