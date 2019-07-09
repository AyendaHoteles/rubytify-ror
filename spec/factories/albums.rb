# == Schema Information
#
# Table name: albums
#
#  id           :integer          not null, primary key
#  artist_id    :integer
#  name         :string
#  spotify_url  :text
#  total_tracks :integer
#  spotify_id   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :text
#

FactoryBot.define do
  factory :album do
    name { Faker::Name.first_name }
    spotify_url { "https://urlspotifyexample.com" }
    total_tracks { Faker::Number.number(2)}
    spotify_id { Faker::Alphanumeric.alphanumeric(10)}
    image { [{ 'url' => 'www.urlimageexample.com' }]}
  end
end

