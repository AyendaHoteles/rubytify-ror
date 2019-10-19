require 'rails_helper'

RSpec.describe Artist, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:spotify_url) }
  end

  context 'associations' do
    it { have_many(:albums) }
    it { have_many(:songs) }
    it { have_and_belong_to_many(:genres) }
  end
end
