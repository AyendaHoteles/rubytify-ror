# == Schema Information
#
# Table name: albums
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  spotify_id   :string
#  image        :string
#  artist_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Album, type: :model do
  it {should belong_to(:artist)}
  it { should have_many(:songs) }
  it { should validate_presence_of(:image)}
  it { should validate_presence_of(:spotify_id)}
  it { should validate_presence_of(:spotify_url)}
  it { should validate_presence_of(:total_tracks)}
  it { should validate_uniqueness_of(:spotify_id)}
  it { should validate_uniqueness_of(:spotify_url)}
end
