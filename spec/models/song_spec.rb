require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'associations' do
    it { should belong_to(:album) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:preview_url) }
    it { should validate_presence_of(:duration_ms) }
    it { should validate_presence_of(:explicit) }
    it { should validate_presence_of(:spotify_id) }
  end
end
