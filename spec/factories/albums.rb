# == Schema Information
#
# Table name: albums
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  spotify_url  :string
#  total_tracks :integer
#  spotify_id   :string
#  image        :string
#  artist_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :album do
    name { Faker::Number.number(10)  }
    image { Faker::Number.number(10) }
    total_tracks { Faker::Number.number(5) }
    spotify_id { Faker::Number.number(5) }
    spotify_url { Faker::Number.number(5) }
    association :artist
  end
end
