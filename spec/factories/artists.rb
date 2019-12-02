FactoryBot.define do

  factory :artist do
    name { Faker::Name.first_name }
    image { 'https://www.google.com.co/' }
    popularity { Faker::Number.number(digits: 1) }
    spotify_url { 'https://www.google.com.co/' }
    spotify_id { Faker::Alphanumeric.alphanumeric(number: 15) }
  end

end
