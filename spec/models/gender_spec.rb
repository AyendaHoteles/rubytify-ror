require 'rails_helper'

RSpec.describe Gender, type: :model do
  # Association test
  it { should have_many(:songs).dependent(:destroy) }
  it { should have_many(:artists).dependent(:destroy) }
  it { should have_many(:relations).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:name) }
end
