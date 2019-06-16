# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  # Existing attributes
  it { should respond_to(:name) }
  it { should respond_to(:image) }
  it { should respond_to(:genres) }
  it { should respond_to(:popularity) }
  it { should respond_to(:spotify_id) }
  it { should respond_to(:spotify_url) }

  # Relationships
  it { should have_many(:albums) }

  # Required fields
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:spotify_id) }
  it { should validate_presence_of(:spotify_url) }
end
