require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'validations' do
    it { should validate_uniqueness_of(:name) }
  end

  context 'associations' do
    it { have_and_belong_to_many(:artists) }
  end
end
