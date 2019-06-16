FactoryBot.define do

  factory :song do
    association :album, factory: :album
    name {"Beautiful Disaster"}
    spotify_url {"https://open.spotify.com/track/1KlKUw0gEbt5CVMq95TeIb"}
    preview_url {"https://p.scdn.co/mp3-preview/9e46fc449622ada2fb8cfe6f29a32b7d57ad1aba?cid=6b9a13d356e14f5d840c798a9fba8cb4"}
    duration_ms {"170760"}
    explicit {"t"}
    spotify_id {"1KlKUw0gEbt5CVMq95TeIb"}
  end

end
