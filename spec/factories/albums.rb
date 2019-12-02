FactoryBot.define do

  factory :album do
    name { Faker::Name.first_name }
    image { 'https://www.google.com.co/' }
    spotify_url { 'https://www.google.com.co/' }
    total_tracks { Faker::Number.number(digits: 1) }
    spotify_id { Faker::Alphanumeric.alphanumeric(number: 15) }
  end

end
