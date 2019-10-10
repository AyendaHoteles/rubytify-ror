FactoryBot.define do
  factory :genre, class: "Genre" do
    name { "Rap" }
  end

  factory :artist do
    name { "Sazam" }
    image { "https://i.scdn.co/image/a1d3360fc175bdc3d6a6d54ac009d46bb14b57d7" }
    popularity { 11 }
    spotify_url { "https://open.spotify.com/artist/1Yg3kLOjToMQcs3semxTuS" }
    spotify_id { "1Yg3kLOjToMQcs3semxTuS" }
  end

  factory :album do
    artist
    name { "Supernova" }
    image { "https://i.scdn.co/image/ab67616d0000b273ccbe1794dd0dba04e92311a6" }
    spotify_url { "https://open.spotify.com/album/3vV5Un40N1aNSt5R83s70w" }
    total_tracks { 13 }
    spotify_id { "3vV5Un40N1aNSt5R83s70w" }
    artist_spotify_id { artist.id }
  end

  factory :song do
    album
    genre
    name { "Make It" }
    spotify_url { "https://open.spotify.com/track/2RMHHMQ5c2rL8V4QzQ4dyv" }
    preview_url { "https://p.scdn.co/mp3-preview/94b69e2aa85ed4841a0a5465c077c521eafce464?cid=774b29d4f13844c495f206cafdad9c86" }
    duration_ms { "161958" }
    explicit { false }
    spotify_id { "2RMHHMQ5c2rL8V4QzQ4dyv" }
  end
end
