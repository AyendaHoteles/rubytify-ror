require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::GenresController, type: :controller do
  context 'Get Song by genre aleatory #aleatory_song_by_gender' do
    before(:each) do
      FactoryBot.create(:genre, name: 'rock')
    end

    it "genre don't exist" do
      get :aleatory_song_by_gender, params: {genre_name: 'pop'}
      expect(response).to have_http_status(:not_found)
    end

    #it 'return songs' do
    #  get :aleatory_song_by_gender, params: {genre_name: 'rock'}
    #  expect(response).to have_http_status(:success)
    #end
  end
end