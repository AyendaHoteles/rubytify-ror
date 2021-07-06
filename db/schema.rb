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

ActiveRecord::Schema.define(version: 2021_07_01_042219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer "id_artist"
    t.string "name"
    t.text "image"
    t.text "spotify_url"
    t.integer "total_tracks"
    t.text "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.text "image"
    t.json "genres"
    t.integer "popularity"
    t.text "spotify_url"
    t.text "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.integer "id_album"
    t.string "name"
    t.text "spotify_url"
    t.text "preview_url"
    t.integer "duration_ms"
    t.boolean "explicit"
    t.text "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
