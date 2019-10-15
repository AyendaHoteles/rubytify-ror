# == Schema Information
#
# Table name: songs
#
#  id          :bigint           not null, primary key
#  duration_ms :integer
#  explicit    :boolean
#  name        :string
#  preview_url :string
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  album_id    :integer
#  genre_id    :integer
#

require 'rails_helper'

RSpec.describe Song, type: :model do
  it { is_expected.to belong_to(:album) }
  it { is_expected.to belong_to(:genre) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:spotify_url) }

  describe ".random_song" do
    context "when gender does exist" do
      context "song does have the corresponding genre" do
      end

      context "song does not have the corresponding genre" do
      end
    end

    context "when gender does not exist" do

    end
  end
end
