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

ActiveRecord::Schema.define(version: 2019_11_28_050137) do

  create_table "albums", force: :cascade do |t|
    t.integer "artist_id"
    t.string "name"
    t.text "image"
    t.string "spotify_url"
    t.integer "total_tracks"
    t.string "spotify_id"
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.text "image"
    t.text "genres", default: "--- []\n"
    t.integer "popularity"
    t.string "spotify_url"
    t.string "spotify_id"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "album_id"
    t.string "name"
    t.string "spotify_url"
    t.string "preview_url"
    t.integer "duration_ms"
    t.boolean "explicit"
    t.string "spotify_id"
    t.index ["album_id"], name: "index_songs_on_album_id"
  end

end
