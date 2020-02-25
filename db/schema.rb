# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_21_183500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "albums", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id"
    t.string "name", null: false
    t.string "image", default: ""
    t.integer "total_tracks", default: 0
    t.string "spotify_url", null: false
    t.string "spotify_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["spotify_id"], name: "index_albums_on_spotify_id"
  end

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "image", null: false
    t.string "genres", default: [], array: true
    t.integer "popularity", default: 0
    t.string "spotify_url", null: false
    t.string "spotify_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spotify_id"], name: "index_artists_on_spotify_id"
  end

  create_table "songs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "album_id"
    t.string "name", null: false
    t.string "preview_url", null: false
    t.integer "duration_ms", default: 0
    t.boolean "explicit", default: false
    t.string "spotify_url", null: false
    t.string "spotify_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_songs_on_album_id"
    t.index ["spotify_id"], name: "index_songs_on_spotify_id"
  end

end
