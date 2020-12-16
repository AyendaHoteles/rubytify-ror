require 'rails_helper'

RSpec.describe Api::V1::AlbumsController do
  describe 'GET #index' do
    subject(:http_request) { get :index }

    it 'responds with ok status code' do
      expect(response).to have_http_status(:ok)
    end

  end
end
