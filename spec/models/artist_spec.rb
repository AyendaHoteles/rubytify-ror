# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  name        :string
#  image       :text
#  popularity  :integer
#  spotify_url :text
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
    it { should have_many(:albums).dependent(:destroy) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:popularity) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:created_at) }
end
