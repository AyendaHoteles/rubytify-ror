# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_one(:image).dependent(:destroy) }
  end
end
