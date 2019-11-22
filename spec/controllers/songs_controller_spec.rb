require "rails_helper"

RSpec.describe Api::V1::SongsController, type: :controller do
  describe "test correct routes and methods" do
    it "test get /api/v1/genres/:genre_name/random_song route" do
      should route(:get, "/api/v1/genres/rock/random_song").to(action: :random_song, genre_name: "rock")
    end
  end
end
