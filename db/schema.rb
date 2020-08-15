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

ActiveRecord::Schema.define(version: 2020_08_13_195547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "astros", force: :cascade do |t|
    t.text "astronomicalDawn", default: "", null: false
    t.text "astronomicalDusk", default: "", null: false
    t.text "civilDawn", default: "", null: false
    t.text "civilDusk", default: "", null: false
    t.float "moonFraction", default: 0.0, null: false
    t.text "moonPhase", default: "", null: false
    t.text "moonrise", default: "", null: false
    t.text "moonset", default: "", null: false
    t.text "sunset", default: "", null: false
    t.text "sunrise", default: "", null: false
    t.datetime "time", null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_astros_on_trip_id"
  end

  create_table "tides", force: :cascade do |t|
    t.datetime "date", null: false
    t.float "first_type", default: 0.0, null: false
    t.text "first_time", default: ""
    t.float "second_type", default: 0.0, null: false
    t.text "second_time", default: ""
    t.float "third_type", default: 0.0, null: false
    t.text "third_time", default: ""
    t.float "fourth_type", default: 0.0, null: false
    t.text "fourth_time", default: ""
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_tides_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name", null: false
    t.string "success", null: false
    t.string "species", null: false
    t.text "body", default: ""
    t.decimal "latitude", default: "0.0", null: false
    t.decimal "longitude", default: "0.0", null: false
    t.datetime "trip_time", null: false
    t.string "text_date", default: "", null: false
    t.bigint "user_id", null: false
    t.boolean "shared"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.datetime "time", null: false
    t.string "text_date", null: false
    t.float "airTemperature", default: 0.0, null: false
    t.float "pressure", default: 0.0, null: false
    t.float "cloudCover", default: 0.0, null: false
    t.float "currentDirection", default: 0.0, null: false
    t.float "currentSpeed", default: 0.0, null: false
    t.float "gust", default: 0.0, null: false
    t.float "humidity", default: 0.0, null: false
    t.float "seaLevel", default: 0.0, null: false
    t.float "visibility", default: 0.0, null: false
    t.float "windDirection", default: 0.0, null: false
    t.float "windSpeed", default: 0.0, null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_weathers_on_trip_id"
  end

end
