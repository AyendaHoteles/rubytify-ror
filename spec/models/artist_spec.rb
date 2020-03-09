require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:spotify_url) }
    it { is_expected.to validate_presence_of(:spotify_id) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:albums).dependent(:destroy) }
    it { is_expected.to have_many(:songs).through(:albums) }
  end

  context 'methods' do
    describe 'create_from_spotify' do
      it 'Services::Spotify::Artist create should be called' do
        expect(Services::Spotify::Artist).to receive(:create).and_return(true)
        Artist.create_from_spotify('Juan')
      end
    end
  end
end
