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

  describe ".create_songs" do
    context "when artist does not exist" do
      context "when song data is complete" do
        it "create artist" do
        end
      end

      context "when song could not be found in spotify" do
        it "returns false" do
        end

        it "does not call parse service" do
        end

        it "song does not increase its elements" do
        end
      end

      context "when song data is not complete" do
        it "rise error" do

        end
      end
    end
    
    context "when song does exist" do
      it "returns true" do
        end
    end
  end
end
