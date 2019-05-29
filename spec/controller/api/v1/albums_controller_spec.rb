# spec/controllers/api/v1/albums_controller_spec.rb

require 'rails_helper'
RSpec.describe Api::V1::AlbumsController, :type => :controller  do
  before(:all) do
    album = create(:album)
  end

  describe "GET album#get_songs" do

    it "returns http success" do
      get :get_songs, params: {id: 1}
      expect(response).to have_http_status(:success)
    end

  end
end