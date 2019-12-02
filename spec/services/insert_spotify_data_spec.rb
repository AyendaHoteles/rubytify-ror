require "rails_helper"

RSpec.describe InsertSpotifyData do

  describe "Test Service" do
    before(:each) do
      service = InsertSpotifyData.new
      @spotify_artist = service.get_artist('Carlos Vives')
      @spotify_artist_blank = service.get_artist('.....')
      @artists_names = service.artists_names
      @artist = service.save_artist(@spotify_artist)
      @artist_blank = service.save_artist(@spotify_artist_blank)
    end

    it 'should spotify artist present' do
      expect(@spotify_artist.present?).to eq true
    end

    it 'should spotify artist blank' do
      expect(@spotify_artist_blank).to eq nil
    end

    it 'should artists names' do
      expect(@artists_names).to be_an(Array)
    end

    it 'should save data' do
      expect(@artist.persisted?).to eq(true)
      expect(@artist_blank).to eq(nil)
    end
  end

end
