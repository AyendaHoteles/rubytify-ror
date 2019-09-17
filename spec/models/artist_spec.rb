require 'rails_helper'

RSpec.describe Artist, type: :model do
  # Association test
  it { should have_many(:albums).dependent(:destroy) }
  it { should have_many(:genders).dependent(:destroy) }
  it { should have_many(:relations).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:popularity) }
  it { should validate_presence_of(:spotify_url) }
  it { should validate_presence_of(:spotify_id) }
end
