FactoryGirl.define do
  factory :artist do
    name "MyString"
    image "MyString"
    genres ['genre1', 'genre2']
    popularity 1
    sequence(:spotify_url) { |n| "https://test.com/artist/#{n}" }
    sequence(:spotify_id) { |n| "artistabc12#{n}" }
  end
end
