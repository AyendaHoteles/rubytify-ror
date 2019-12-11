require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'field validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:preview_url) }
    it { should validate_presence_of(:duration_ms) }

    it { should belong_to(:album) }
  end
end
