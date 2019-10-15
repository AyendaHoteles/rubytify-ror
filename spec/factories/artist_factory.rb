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

FactoryBot.define do
  factory :artist do
    name        { "Metallica" }
    image       { "https://i.scdn.co/image/5a06711d7fc48d5e0e3f9a3274ffed3f0af1bd91" }
    popularity  { 83 }
    spotify_url { "https://open.spotify.com/artist/2ye2Wgw4gimLv2eAKyk1NB" }
  end
end

