# == Schema Information
#
# Table name: songs
#
#  id          :bigint           not null, primary key
#  name        :string
#  spotify_url :text
#  preview_url :text
#  duration_ms :integer
#  explicit    :boolean          default(FALSE)
#  spotify_id  :string
#  album_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Song, type: :model do
    it { should belong_to(:album) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:spotify_url) }
    it { should validate_presence_of(:preview_url) }
    it { should validate_presence_of(:duration_ms) }
    it { should validate_presence_of(:explicit) }
    it { should validate_presence_of(:spotify_id) }
    it { should validate_presence_of(:album_id) }
end
