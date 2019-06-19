# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  image       :string
#  genres      :string
#  popularity  :integer
#  spotify_url :string
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


FactoryBot.define do
  factory :artist do
    name { Faker::Number.number(10)  }
    image { Faker::Number.number(10) }
    popularity { Faker::Number.number(5) }
    spotify_url { Faker::Number.number(10) }
    spotify_id { Faker::Number.number(10) }
  end
end
