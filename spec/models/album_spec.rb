require 'rails_helper'

RSpec.describe Album, type: :model do
  # Association test
  # ensure an album record belongs to a single artist record
  it { should belong_to(:artist) }
  it { should have_many(:songs).dependent(:destroy) }

  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
