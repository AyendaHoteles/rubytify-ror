require 'rails_helper'

RSpec.describe Song, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:album_id) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:duration_ms) }
  end

  context 'associations' do
    it { belong_to(:album) }
  end
end
