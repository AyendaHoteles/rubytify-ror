RSpec.describe Spotify::ComunicationService, type: :service do
  describe ".get_artist_id" do
    let(:spotify_artist_response) {
      {
        external_urls: {
          spotify: "https://open.spotify.com/artist/3MqjsWDLhq8SyY6N3PE8yW"
        },
        followers: {
          href: null,
          total: 390826
        },
        genres: [ "colombian rock", "cumbia", "latin", "latin alternative", "latin pop", "latin rock", "rock en espanol" ],
        href: "https://api.spotify.com/v1/artists/3MqjsWDLhq8SyY6N3PE8yW",
        id: "3MqjsWDLhq8SyY6N3PE8yW",
        images: [ {
          height: 640,
          url "https://i.scdn.co/image/3d1ac6131bac714406d00c0cafdf069a2ae294c2",
          width: 640
        }, {
          height: 320,
          url: "https://i.scdn.co/image/23b73e61ded16ca80113bf7ac7c04c3a90f5ca3c",
          width: 320
        }, {
          height: 160,
          url: "https://i.scdn.co/image/b981b26ee22d9700fe7b7fce4db6723f06a6f037",
          width: 160
        } ],
        name: "Aterciopelados",
        popularity: 59,
        type: "artist",
        uri: "spotify:artist:3MqjsWDLhq8SyY6N3PE8yW"
      }
    }

    let(:spotify_search_response) {
      {
        artists: {
          href: "https://api.spotify.com/v1/search?query=aterciopelados&type=artist&offset=0&limit=20",
          items: [ {
            external_urls: {
              spotify: "https://open.spotify.com/artist/3MqjsWDLhq8SyY6N3PE8yW"
            },
            followers: {
              href: null,
              total: 390826
            },
            genres: [ "colombian rock", "cumbia", "latin", "latin alternative", "latin pop", "latin rock", "rock en espanol" ],
            href: "https://api.spotify.com/v1/artists/3MqjsWDLhq8SyY6N3PE8yW",
            id: "3MqjsWDLhq8SyY6N3PE8yW",
            images: [ {
              height: 640,
              url: "https://i.scdn.co/image/3d1ac6131bac714406d00c0cafdf069a2ae294c2",
              width: 640
            }, {
              height: 320,
              url: "https://i.scdn.co/image/23b73e61ded16ca80113bf7ac7c04c3a90f5ca3c",
              width: 320
            }, {
              height: 160,
              url: "https://i.scdn.co/image/b981b26ee22d9700fe7b7fce4db6723f06a6f037",
              width: 160
            } ],
            name: "Aterciopelados",
            popularity: 59,
            type: "artist",
            uri: "spotify:artist:3MqjsWDLhq8SyY6N3PE8yW"
          } ],
          limit: 20,
          next: null,
          offset: 0,
          previous: null,
          total: 1
        }
      }
    }

    let(:spotify_empty){
      {
        artists: {
          href:     "https://api.spotify.com/v1/search?query=atercipelados&type=artist&offset=0&limit=20",
          items:    [ ],
          limit:    20,
          next:     null,
          offset:   0,
          previous: null,
          total:    0
        }
      }
    }

    subject { described_class.get_artist_id(name: name) }

    context "when artist can be found" do
      let(:name) { "Aterciopelados" }

      before { allow(HTTParty).to receive(:get).and_return(OpenStruct.new({code: 200, body: spotify_search_response.to_json})) }

      it "return artist spotify id" do
        expect(subject).to eq("3MqjsWDLhq8SyY6N3PE8yW")
      end
    end

    context "when artist could not be found" do
      let(:name) { "Atercipelados" }

      before { allow(HTTParty).to receive(:get).and_return(OpenStruct.new({code: 200, body: spotify_empty.to_json})) }
      
      it "returns nil" do
        expect(subject).to eq(nil)
      end
    end
  end

  describe ".get_artist_id" do
    subject { described_class.get_artist(name: name) }

    context "when artist can be found" do
      let(:name) { "Aterciopelados" }

      before { allow(described_class).to receive(:get_artist_id).and_return("3MqjsWDLhq8SyY6N3PE8yW") }

      it "return artist spotify id" do
        expect(subject).to eq(spotify_artist_response.to_json)
      end
    end

    context "when artist could not be found" do
      let(:name) { "Atercipelados" }

      before { allow(described_class).to receive(:get_artist_id).and_return(nil) }
      
      it "returns nil" do
        expect(subject).to eq(nil)
      end
    end
  end
end