require 'rails_helper'

RSpec.describe Gender, type: :model do
  # Association test
  it { should have_many(:songs).dependent(:destroy) }
  # Validation
  it { should validate_presence_of(:name) }
end
