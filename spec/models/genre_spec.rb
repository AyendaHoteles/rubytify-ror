require 'rails_helper'

RSpec.describe Genre, type: :model do
  it { should have_and_belong_to_many(:artists) }
  it { should have_many(:songs).through(:artists) }
  it { should validate_presence_of(:name) }
end
