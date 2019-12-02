require 'rails_helper'



RSpec.describe "Endpoints", type: :request do

  before :all do 
    Album.destroy_all
    Artist.destroy_all
    Song.destroy_all
    load "#{Rails.root}/db/seeds.rb"  
  end
  describe "GET /artists" do
    it "works! (now write some real specs)" do
      get "http://localhost:3000/api/v1/artists/"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /albums" do
    it "works!" do
      get "http://localhost:3000/api/v1/artists/1/albums"
      
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /albums" do
    it "works! " do
      get "http://localhost:3000/api/v1/genres/metal/random_song"
      
      expect(response).to have_http_status(200)
    end
  end

  describe "GET songs#index" do
    it "works!" do
      get "http://localhost:3000/api/v1/albums/1/songs"
      
      expect(response).to have_http_status(200)
    end
  end
end
