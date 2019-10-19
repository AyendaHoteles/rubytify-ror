require 'rails_helper'

RSpec.describe Song, type: :model do
  # Association test
  # ensure an song record belongs to a single album record
  it { should belong_to(:album) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }  
end
