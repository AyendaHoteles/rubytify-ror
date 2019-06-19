# frozen_string_literal: true

# == Schema Information
#
# Table name: songs
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  spotify_url :string
#  preview_url :string
#  duration_ms :integer
#  explicit    :boolean
#  spotify_id  :string
#  album_id    :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


FactoryBot.define do
  factory :song do
    name { Faker::Number.number(5) }
    spotify_url { Faker::Number.number(5) }
    spotify_id { Faker::Number.number(5) }
    preview_url { Faker::Number.number(5) }
    duration_ms { Faker::Number.number(5) }
    explicit { Faker::Boolean }
    association :album
  end
end
