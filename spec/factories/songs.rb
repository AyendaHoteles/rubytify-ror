FactoryBot.define do

  factory :song do
    name { Faker::Name.first_name }
    spotify_url { "https://#{Faker::Alphanumeric.alphanumeric(number: 15)}/" }
    preview_url { 'https://www.google.com.co/' }
    duration_ms { Faker::Number.number(digits: 2) }
    explicit { true }
    spotify_id { Faker::Alphanumeric.alphanumeric(number: 15) }
  end

end
