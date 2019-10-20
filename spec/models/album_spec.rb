# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  name         :string
#  image        :text
#  spotify_url  :text
#  total_tracks :integer
#  spotify_id   :string
#  artist_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Album, type: :model do
    it { should belong_to(:artist) }
    it { should have_many(:songs).dependent(:destroy) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:total_tracks) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:artist_id) }
    it { should validate_presence_of(:created_at) }
end
