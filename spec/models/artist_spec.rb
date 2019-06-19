# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  image       :string
#  genres      :string
#  popularity  :integer
#  spotify_url :string
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { should have_and_belong_to_many(:genres) }
  it { should have_many(:songs).through(:albums) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:popularity) }
  it { should validate_presence_of(:spotify_url) }
  it { should validate_presence_of(:spotify_id) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:image) }
  it { should validate_uniqueness_of(:spotify_url) }
  it { should validate_uniqueness_of(:spotify_id) }

  it 'should be valid' do
    expect(create(:artist)).to be_valid
  end

  it 'downcase name' do
    artist = create(:artist)
    expect(artist.name).to eq(artist.name.downcase)
  end
end
