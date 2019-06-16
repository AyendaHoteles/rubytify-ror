require 'rails_helper'

RSpec.describe Api::V1::ArtistsController, type: :controller do
  before(:all) do
    artist = create(:artist)
  end

  describe "GET artists" do

    it "returns http success" do
      get :artists
      expect(response).to have_http_status(:success)
    end

  end


end
