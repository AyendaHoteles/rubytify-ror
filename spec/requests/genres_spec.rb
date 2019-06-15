require 'rails_helper'

describe 'GET /genres/:genre_name/random_song' do
  before(:all) do
    @artist = FactoryBot.create(:artist, :with_album)
    @album = FactoryBot.create(:album, :with_song)
  end
  before {get "/api/v1/genres/#{@artist.genres}/random_song"}
  it 'returns a random song with a given genre' do
    json = JSON.parse(response.body)
    expect(json['status']).to eql('SUCCESS')
  end
end
