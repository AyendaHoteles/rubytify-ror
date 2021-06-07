FactoryBot.define do
  factory :album do
    name { 'Music to remember' }
    total_tracks { 12 }
    spotify_url { 'urlspotify.com/8df78dfg8sd' }
    spotify_id { '8df78dfg8sd' }
    artist
  end
end
