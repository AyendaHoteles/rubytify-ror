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
    subject { described_class.create_artist(name: name) }

    context "when artist does not exist" do
      context "when artist data is complete" do
        let(:name) { "aterciopelados" }
        let(:spotify_data) {
          {
            external_urls: {
              spotify: "https://open.spotify.com/artist/3MqjsWDLhq8SyY6N3PE8yW"
            },
            followers: {
              href:  nil,
              total: 391302
            },
            genres: [ "colombian rock", "cumbia", "latin", "latin alternative", "latin pop", "latin rock", "rock en espanol" ],
            href: "https://api.spotify.com/v1/artists/3MqjsWDLhq8SyY6N3PE8yW",
            id: "3MqjsWDLhq8SyY6N3PE8yW",
            images: [ {
              height: 640,
              url:    "https://i.scdn.co/image/3d1ac6131bac714406d00c0cafdf069a2ae294c2",
              width:  640
            }, {
              height: 320,
              url:    "https://i.scdn.co/age/23b73e61ded16ca80113bf7ac7c04c3a90f5ca3c",
              width:  320
            }, {
              height: 160,
              url:    "https://i.scdn.co/image/b981b26ee22d9700fe7b7fce4db6723f06a6f037",
              width:  160
            } ],
            name:       "Aterciopelados",
            popularity: 59,
            type:       "artist",
            uri:        "spotify:artist:3MqjsWDLhq8SyY6N3PE8yW"
          }
        }
        
        let(:spotify_data_parsed) {
          {
            id:          "3MqjsWDLhq8SyY6N3PE8yW",
            name:        "Aterciopelados",
            image:       "https://i.scdn.co/image/3d1ac6131bac714406d00c0cafdf069a2ae294c2", 
            genres:      ["colombian rock", "cumbia", "latin", "latin alternative", "latin pop", "latin rock", "rock en espanol"], 
            popularity:  59, 
            spotify_url: "https://open.spotify.com/artist/3MqjsWDLhq8SyY6N3PE8yW"
          }
        }

        before do 
          allow(Spotify::ComunicationService).to receive(:get_artist).and_return(spotify_data)
          allow(Spotify::ParserService).to receive(:artist).and_return(spotify_data_parsed)
        end

        it "creates artist" do
          expect {
            subject
          }.to change(Artist.all, :count).by(1)
        end

        it "calls spotify comunication service" do
          expect(Spotify::ComunicationService).to receive(:get_artist)
          expect(Spotify::ParserService).to receive(:artist)

          subject
        end

        it { is_expected.to eq(true) }
      end

      context "when artist could not be found in spotify" do
        let(:name) { "abcdefg" }

        before do 
          allow(Spotify::ComunicationService).to receive(:get_artist).and_return(nil)
        end

        it "does not call parse service" do
          expect(Spotify::ParserService).not_to receive(:artist)
        end

        it "creates artist" do
          expect {
            Artist.all
          }.to change(Artist.all, :count).by(0)
        end

        it { is_expected.to eq(false) }
      end

      context "when artist data is not complete" do
        let(:name)         { "aterciopelados" }
        let(:spotify_data) {
          {
            external_urls: {
              spotify: "https://open.spotify.com/artist/3MqjsWDLhq8SyY6N3PE8yW"
            },
            followers: {
              href:  nil,
              total: 391302
            },
            genres: [ "colombian rock", "cumbia", "latin", "latin alternative", "latin pop", "latin rock", "rock en espanol" ],
            href: "https://api.spotify.com/v1/artists/3MqjsWDLhq8SyY6N3PE8yW",
            id: "3MqjsWDLhq8SyY6N3PE8yW",
            images: [ {
              height: 640,
              url:    "https://i.scdn.co/image/3d1ac6131bac714406d00c0cafdf069a2ae294c2",
              width:  640
            }, {
              height: 320,
              url:    "https://i.scdn.co/age/23b73e61ded16ca80113bf7ac7c04c3a90f5ca3c",
              width:  320
            }, {
              height: 160,
              url:    "https://i.scdn.co/image/b981b26ee22d9700fe7b7fce4db6723f06a6f037",
              width:  160
            } ],
            name:       nil,
            popularity: 59,
            type:       "artist",
            uri:        "spotify:artist:3MqjsWDLhq8SyY6N3PE8yW"
          }
        }
        
        let(:spotify_data_parsed) {
          {
            id:          "3MqjsWDLhq8SyY6N3PE8yW",
            name:        nil,
            image:       "https://i.scdn.co/image/3d1ac6131bac714406d00c0cafdf069a2ae294c2", 
            genres:      ["colombian rock", "cumbia", "latin", "latin alternative", "latin pop", "latin rock", "rock en espanol"], 
            popularity:  59, 
            spotify_url: "https://open.spotify.com/artist/3MqjsWDLhq8SyY6N3PE8yW"
          }
        }

        before do 
          allow(Spotify::ComunicationService).to receive(:get_artist).and_return(spotify_data)
          allow(Spotify::ParserService).to receive(:artist).and_return(spotify_data_parsed)
        end

        it "rise error" do
           expect { raise StandardError }.to raise_error
        end
      end
    end
    
    context "when artist does exist" do
      let(:artist) { create :artist }
      let(:name)   { artist.name }

      it "does not call spotify comunication service" do
        expect(Spotify::ComunicationService).not_to receive(:get_artist)
        expect(Spotify::ParserService).not_to receive(:artist)

        subject
      end

      it { is_expected.to eq(true) }
    end
  end

  describe ".create_albums" do
    context "when album does not exist" do
      context "when album data is complete" do
        it "create album" do
        end
      end

      context "when album could not be found in spotify" do
        it "returns false" do
        end

        it "does not call parse service" do
        end

        it "Album does not increase its elements" do
        end
      end

      context "when album data is not complete" do
        it "rise error" do

        end
      end
    end
    
    context "when album does exist" do
      it "returns true" do
        end
    end
  end
end
