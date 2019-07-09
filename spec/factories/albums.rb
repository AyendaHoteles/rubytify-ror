FactoryGirl.define do
  factory :album do
    artist nil
    name "MyString"
    image "MyString"
    total_tracks 1
    sequence(:spotify_url) { |n| "https://test.com/albums/#{n}" }
    sequence(:spotify_id) { |n| "albumabc12#{n}" }
  end
end
