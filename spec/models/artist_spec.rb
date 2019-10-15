# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  image       :string
#  name        :string
#  popularity  :integer
#  spotify_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  spotify_id  :string
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:spotify_url) }

  describe ".create_artist" do
    subject { described_class.get_artist_id(name: name) }

    context "when artist does not exist" do
      context "when artist data is complete" do
        it "create artist" do
        end
      end

      context "when artist could not be found in spotify" do
        it "returns false" do
        end

        it "does not call parse service" do
        end

        it "Artist does not increase its elements" do
        end
      end

      context "when artist data is not complete" do
        it "rise error" do

        end
      end
    end
    
    context "when artist does exist" do
      it "returns true" do
        end
    end
  end
end
