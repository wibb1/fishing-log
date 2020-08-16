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
    t.string "astronomicalDawn", default: "NA"
    t.string "astronomicalDusk", default: "NA"
    t.string "civilDawn", default: "NA"
    t.string "civilDusk", default: "NA"
    t.string "moonFraction", default: "NA"
    t.string "moonPhase", default: "NA"
    t.string "moonrise", default: "NA"
    t.string "moonset", default: "NA"
    t.string "sunset", default: "NA"
    t.string "sunrise", default: "NA"
    t.string "date", default: "NA"
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_astros_on_trip_id"
  end

  create_table "tides", force: :cascade do |t|
    t.string "date", null: false
    t.string "first_type", default: "NA"
    t.string "first_time", default: "NA"
    t.string "second_type", default: "NA"
    t.string "second_time", default: "NA"
    t.string "third_type", default: "NA"
    t.string "third_time", default: "NA"
    t.string "fourth_type", default: "NA"
    t.string "fourth_time", default: "NA"
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_tides_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name", null: false
    t.string "success", null: false
    t.string "species", null: false
    t.text "body"
    t.decimal "latitude", null: false
    t.decimal "longitude", null: false
    t.string "date", null: false
    t.string "time", null: false
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
    t.string "date", null: false
    t.string "time", null: false
    t.string "airTemperature", default: "NA"
    t.string "pressure", default: "NA"
    t.string "cloudCover", default: "NA"
    t.string "currentDirection", default: "NA"
    t.string "currentSpeed", default: "NA"
    t.string "gust", default: "NA"
    t.string "humidity", default: "NA"
    t.string "seaLevel", default: "NA"
    t.string "visibility", default: "NA"
    t.string "windDirection", default: "NA"
    t.string "windSpeed", default: "NA"
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_weathers_on_trip_id"
  end

end
