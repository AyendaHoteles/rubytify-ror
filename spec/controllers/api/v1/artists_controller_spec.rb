require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
  describe "#index" do
    subject { get :index }
    
    context "when there are artist stored" do
      let!(:artist)       { create :artist }
      let(:response_body) {
        {
          data:[
            {
              id:          8,
              name:        "Metallica",
              image:       "https://i.scdn.co/image/5a06711d7fc48d5e0e3f9a3274ffed3f0af1bd91",
              genres:      "hard rock, metal, old school thrash, rock, speed metal, thrash metal",
              popularity:  83,
              spotify_url: "https://open.spotify.com/artist/2ye2Wgw4gimLv2eAKyk1NB"
            }
          ]
        }.to_json
      }

      it "returns artist" do
        subject
        expect(response.body).to be ==(response_body)
      end

      it "returns status ok" do
        subject
        expect(response.status).to eq(200)
      end
    end

    context "when there are no artist stored" do
      let(:response_body) { {data: []}.to_json }

      it "returns status 204" do
        subject
        expect(response.status).to eq(204)
      end
    end
  end
end
