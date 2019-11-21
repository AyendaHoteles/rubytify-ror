require "rails_helper"

RSpec.describe Api::V1::ArtistsController, type: :controller do
  describe "test correct routes and methods" do
    it "test get /api/v1/artists route" do
      should route(:get, "/api/v1/artists").to(action: :index)
    end

    it "test get /api/v1/artists/:id/albums route" do
      should route(:get, "/api/v1/artists").to(action: :albums)
    end
  end
end
