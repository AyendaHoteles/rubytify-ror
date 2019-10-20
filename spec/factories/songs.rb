FactoryBot.define do
  factory :song do
    name { 'Star Treatment' }
    spotify_url { 'https://open.spotify.com/track/0FgNSsaSZTvbLXUumSO8LQ' }
    preview_url { 'https://p.scdn.co/mp3-preview/96cf115e9813becf7d7d39f80fcc6a929666858f?cid=78bc4fb9a87c4cb993afae300cdc27f3' }
    duration_ms { 354_640 }
    explicit { false }
    spotify_id { '0FgNSsaSZTvbLXUumSO8LQ' }
  end
end
