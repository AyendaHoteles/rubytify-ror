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

ActiveRecord::Schema.define(version: 2019_07_06_103830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "spotify_url"
    t.integer "total_tracks"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.text "genres", default: [], array: true
    t.integer "popularity"
    t.string "spotify_url"
    t.string "spotify_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genres"], name: "index_artists_on_genres", using: :gin
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.integer "width"
    t.integer "height"
    t.string "owner_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_images_on_owner_type_and_owner_id"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "album_id"
    t.string "name"
    t.string "spotify_url"
    t.string "preview_url"
    t.integer "duration_ms"
    t.boolean "explicit", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_songs_on_album_id"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "songs", "albums"
end
