# == Schema Information
#
# Table name: songs
#
#  id          :integer          not null, primary key
#  album_id    :integer
#  name        :string
#  spotify_url :text
#  preview_url :text
#  duration_ms :integer
#  explicit    :boolean
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  artist_id   :integer
#
FactoryBot.define do
  factory :song do
    name { Faker::Name.first_name }
    spotify_url { "https://urlspotifyexample.com" }
    preview_url { "https://urlpreviewurlspotifyexample.com" }
    duration_ms { Faker::Number.number(5) }
    explicit { true }
    spotify_id { Faker::Alphanumeric.alphanumeric(10)}
  end
end

