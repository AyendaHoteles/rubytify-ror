require 'rails_helper'

describe 'GET /albums/:id/songs' do
  before(:all) do
    @album = FactoryBot.create(:album, :with_song)
  end
  before {get "/api/v1/albums/#{@album.id}/songs"}
  it 'returns all songs in an album' do
    json = JSON.parse(response.body)
    expect(json['status']).to eql('SUCCESS')
  end
end
