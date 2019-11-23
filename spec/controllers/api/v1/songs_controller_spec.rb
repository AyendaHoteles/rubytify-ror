require 'rails_helper'

RSpec.describe Api::V1::SongsController, type: :controller do
	describe 'endpoints' do
		let(:request_response_body) do
       JSON.parse(response.body)
	   end
    let(:artist) { create(:artist) }
    let(:album) { create(:album, artist_id: artist.id) }

    before do
    	4.times do
    		create(:song, album_id: album.id)
    	end
	  end
		
		context '#index' do
			it "should returns a list of songs" do
			  get :index, params: { album_id: album.id }

			  expect(response.status).to eq 200
			  expect(request_response_body.last).to match_json_schema('song')
			end
		end

		context '#random_song' do
			let(:artist) { create(:artist, name: "pacho rada", genres: ["vallenato"] ) }
	    let(:album) { create(:album, name: "El tigre de la montaña", artist_id: artist.id) }

	    before do
	    	4.times do
	    		create(:song, album_id: album.id)
	    	end
	  	end

			it "should returns a random song" do
			  get :random_song, params: { genre_name: "vallenato" }

			  expect(response.status).to eq 200
			  expect(request_response_body).to match_json_schema('song')
			end
		end
	end
end
