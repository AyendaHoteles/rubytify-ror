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


FactoryBot.define do
  factory :song do
    album
    genre 

    name        { "massacre" }
    preview_url { "https://i.scdn.co/image/5a06711d7fc48d5e0e3f9a3274ffed3f0af1bd91" }
    spotify_url { "https://open.spotify.com/artist/2ye2Wgw4gimLv2eAKyk1NB" }
    explicit    { false }
  end
end

