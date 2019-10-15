require 'rails_helper'

RSpec.describe Api::V1::AlbumsController, type: :controller do
  describe "#index" do
    let(:artist) { create :artist }
    let(:params) { 1 }

    subject { get :index }
    
    context "when there are artist stored" do
      it "return artist" do
        puts artist
        subject
        expect(response.body).to eq(true)
      end

      it "return status ok" do
     
      end
    end
  end
end
