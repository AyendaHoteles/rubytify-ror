require 'rails_helper'


RSpec.describe 'Rubytify API', type: :request do
  # initialize test data 
  let!(:artists) { create_list(:artist, 1) }
  let(:artist_id) { artists.first.id }

  describe 'GET /api/v1/artists' do
    # make HTTP get request before each example
    before { get '/api/v1/artists' }

    it 'returns artists' do
      result = JSON(response.body)
      expect(result).not_to be_empty
      expect(result.size).to eq(1) 
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
