require "rails_helper"

RSpec.describe Api::V1::AlbumsController, type: :controller do
  describe "test correct routes and methods" do
    it "test get /api/v1/albums/:id/songs route" do
      should route(:get, "/api/v1/albums/30/songs").to(action: :songs, id: 30)
    end
  end
end
