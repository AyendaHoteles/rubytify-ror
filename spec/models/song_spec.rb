# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Song, type: :model do
  # Existing attributes
  it { should respond_to(:name) }
  it { should respond_to(:duration_ms) }
  it { should respond_to(:explicit) }
  it { should respond_to(:preview_url) }
  it { should respond_to(:spotify_id) }
  it { should respond_to(:spotify_url) }

  # Relationships
  it { should belong_to(:album) }

  # Required fields
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:preview_url) }
  it { should validate_presence_of(:spotify_id) }
  it { should validate_presence_of(:spotify_url) }
end
