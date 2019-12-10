require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'field validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:total_tracks) }

    it { should belong_to(:artist) }
    it { should have_many(:songs) }
  end
end
