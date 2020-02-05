require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'associations' do
   it { should have_many(:albums)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:genres) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:spotify_id) }
  end
end
