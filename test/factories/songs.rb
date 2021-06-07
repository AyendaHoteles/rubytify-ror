FactoryBot.define do
  factory :song do
    name { 'Save your tears' }
    duration_ms { 207959 }
    explicit { false }
    preview_url { 'https://p.scdn.co/78fgdsg8' }
    spotify_url { 'urlspotify.com/2132kkdfdf90dg' }
    spotify_id { '2132kkdfdf90dg' }
    album
  end
end
