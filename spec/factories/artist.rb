FactoryGirl.define do
  factory :artist do
    name 'Dummy'
    genres ['rock', 'pop'].to_json
    popularity 8
    sequence(:spotify_url) { |i| "https://-#{i}spotify.com" }
    spotify_id 467
  end
end