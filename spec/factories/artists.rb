# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  name        :string
#  image       :text
#  popularity  :integer
#  spotify_url :text
#  spotify_id  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
    factory :artist do
        name { Faker::Name.name }
        image {'http://image.com'}
        popularity {98}
        spotify_url {'www.example.net'}
        spotify_id {'hkasdhfiyaer469ia'}
    end
end
