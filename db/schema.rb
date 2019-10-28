# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_27_045048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "image", default: "", null: false
    t.string "spotify_url", default: "", null: false
    t.string "total_tracks", default: "0", null: false
    t.string "spotify_id", default: "", null: false
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["name"], name: "index_albums_on_name"
    t.index ["spotify_id"], name: "index_albums_on_spotify_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "image", default: "", null: false
    t.string "genres", default: "", null: false
    t.integer "popularity", limit: 2, default: 0
    t.string "spotify_url", default: "", null: false
    t.string "spotify_id", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genres"], name: "index_artists_on_genres"
    t.index ["name"], name: "index_artists_on_name"
    t.index ["popularity"], name: "index_artists_on_popularity"
    t.index ["spotify_id"], name: "index_artists_on_spotify_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "spotify_url", default: "", null: false
    t.string "preview_url", default: ""
    t.integer "duration_ms", default: 0, null: false
    t.boolean "explicit", default: false
    t.string "spotify_id", default: "", null: false
    t.bigint "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_songs_on_album_id"
    t.index ["duration_ms"], name: "index_songs_on_duration_ms"
    t.index ["explicit"], name: "index_songs_on_explicit"
    t.index ["name"], name: "index_songs_on_name"
    t.index ["spotify_id"], name: "index_songs_on_spotify_id"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "songs", "albums"
end
