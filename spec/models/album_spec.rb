# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  image        :string
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :integer
#  spotify_id   :string
#

require 'rails_helper'

RSpec.describe Album, type: :model do
  it { is_expected.to belong_to(:artist) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:spotify_url) }
end
