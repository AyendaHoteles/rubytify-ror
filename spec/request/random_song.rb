require "rails_helper"

RSpec.describe "Album", type: :request do
    describe "GET /api/v1/genres/:genre_id/random_song" do

        before { get '/api/v1/genres/modern%20rock/random_song' }
        
        it "shoud return one radon song" do
            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(response).to have_http_status(200)
        end
     
     end
end 