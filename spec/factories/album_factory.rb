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

FactoryBot.define do
  factory :album do
    artist

    name         { "Black" }
    image        { "https://i.scdn.co/image/5a06711d7fc48d5e0e3f9a3274ffed3f0af1bd91" }
    total_tracks { 9 }
    spotify_url  { "https://open.spotify.com/artist/2ye2Wgw4gimLv2eAKyk1NB" }
  end
end