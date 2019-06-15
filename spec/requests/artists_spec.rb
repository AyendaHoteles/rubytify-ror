require 'rails_helper'

describe 'GET /api/v1/artists' do
  before(:all) do
    artist = create(:artist)
  end
  before {get '/api/v1/artists'}
  it 'returns all artists' do
    json = JSON.parse(response.body)
    expect(json['status']).to eql('SUCCESS')
  end
end

describe 'Get /artist/:id/albums' do
  before(:all) do
    @artist = FactoryBot.create(:artist, :with_album)
  end
  before {get "/api/v1/artists/#{@artist.id}/albums"}
  it 'returns all albums by an artist' do
    json = JSON.parse(response.body)
    expect(json['status']).to eql('SUCCESS')
  end
end
