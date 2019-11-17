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

ActiveRecord::Schema.define(version: 2019_11_16_235525) do

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "spotify_url"
    t.integer "total_tracks"
    t.string "spotify_id"
    t.string "artist_id"
    t.string "genres"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "spotify_id"
    t.string "name"
    t.string "image"
    t.string "genres"
    t.integer "popularity"
    t.string "spotify_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.string "spotify_url"
    t.string "preview_url"
    t.integer "duration_ms"
    t.boolean "explicit"
    t.string "spotify_id"
    t.string "album_id"
    t.string "genres"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
