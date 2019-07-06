# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:image).dependent(:destroy) }
    it { is_expected.to have_many(:albums).dependent(:destroy) }
  end
end
