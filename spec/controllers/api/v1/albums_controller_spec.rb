require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
	context 'succes request' do
    let!(:artist) { create(:artist) }
		let(:request_response_body) do
      JSON.parse(response.body)
    end

    before do
    	4.times do
    		create(:album, artist_id: artist.id)
    	end
	  end

		it "should returns correct params of albums" do
		  get :index, params: {artist_id: artist.id}

		  expect(response.status).to eq 200
		  expect(request_response_body.last).to match_json_schema('album')
		end
	end
end
