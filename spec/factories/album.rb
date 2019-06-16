FactoryBot.define do

  factory :album do
    association :artist, factory: :artist
    name {"Transistor"}
    image {"https://i.scdn.co/image/472e947ad2e1e52926c12e7b7d3355b2499b7b52"}
    spotify_url {"https://open.spotify.com/album/66MztQRqLYgND6LTeIpRFx"}
    total_tracks {21}
    spotify_id {"66MztQRqLYgND6LTeIpRFx"}
  end

end
