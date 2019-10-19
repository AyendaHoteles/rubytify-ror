FactoryBot.define do
  factory :artist do
    name { 'Arctic Monkeys' }
    image { 'https://i.scdn.co/image/ed0552e9746ed2bbf04ae4bcb5525700ca31522d' }
    genres { ['garage rock', 'indie rock', 'modern rock', 'permanent wave', 'rock', 'sheffield indie'] }
    popularity { 83 }
    spotify_url { 'https://open.spotify.com/artist/7Ln80lUS6He07XvHI8qqHH' }
    spotify_id { '7Ln80lUS6He07XvHI8qqHH' }
  end
end
