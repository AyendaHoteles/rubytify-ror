require 'rails_helper'

RSpec.describe Artist, type: :model do
  
   let(:artist_1) { create(:artist) }

   describe 'associations' do
      it { should have_many(:albums) }
   end
  
   it 'Returns TRUE for an artist that exists' do
      expect(Artist.exist_artist(artist_1.spotify_id)).to eq true
   end 
   
   it 'Returns FALSE for an artist that not exists' do
      artist_2 = Artist.new(name: 'Dummy', popularity: 8, spotify_url: "https://spotify.com", spotify_id: 345)
      
      expect(Artist.exist_artist(artist_2.spotify_id)).to eq false
   end 
end
