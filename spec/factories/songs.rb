FactoryGirl.define do
  factory :song do
    artist nil
    album nil
    name "MyString"
    preview_url "MyString"
    duration_ms 1
    explicit false
    sequence(:spotify_url) { |n| "https://test.com/tracks/#{n}" }
    sequence(:spotify_id) { |n| "trackabc12#{n}" }
  end
end
