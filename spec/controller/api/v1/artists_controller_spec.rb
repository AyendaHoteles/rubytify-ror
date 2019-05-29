# spec/controllers/api/v1/artists_controller_spec.rb

require 'rails_helper'
RSpec.describe Api::V1::ArtistsController, :type => :controller  do
  describe "GET index" do

    before(:all) do
      @artist = create(:artist)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end

  describe "GET artists#get_albums" do

    it "returns http success" do
      get :get_albums, params: {id: 1}
      expect(response).to have_http_status(:success)
    end

  end
end