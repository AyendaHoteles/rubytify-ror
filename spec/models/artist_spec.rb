# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:images).dependent(:destroy) }
  end
end
