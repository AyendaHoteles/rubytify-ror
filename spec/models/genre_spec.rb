# == Schema Information
#
# Table name: genres
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Genre, type: :model do
  it { should have_and_belong_to_many(:artists) }
  it { should have_many(:songs).through(:artists) }
  it { should validate_presence_of(:name) }
end
