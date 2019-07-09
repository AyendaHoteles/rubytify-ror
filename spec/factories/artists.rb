# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string
#  genres      :text
#  popularity  :string
#  spotify_url :text
#  spotify_id  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :text
#
FactoryBot.define do
  factory :artist do
    name { Faker::Name.first_name }
    genres { [Faker::Music.genre, Faker::Music.genre, Faker::Music.genre] }
    popularity { Faker::Number.number(1)}
    spotify_url { "https://urlspotifyexample.com" }
    spotify_id { Faker::Alphanumeric.alphanumeric(10) }
    image { [{ 'url' => 'www.urlimageexample.com' }]}
  end
end
