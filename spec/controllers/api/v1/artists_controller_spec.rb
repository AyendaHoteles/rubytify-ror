require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
	context '' do
    let!(:artist) { create(:artist) }
		let(:request_response_body) do
        request
        JSON.parse(response.body)
    end

		it "returns artists" do
		  get :index
		  byebug
		  expect(response.status).to eq 200
		  expect(request_response_body).to match_json_schema('get_artists_success')
		end
	end
end
