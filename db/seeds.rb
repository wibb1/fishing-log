user1 = User.create(first_name: "Tom", last_name: "Thumb", password: "apple", email: "thumb@aol.com")
trip1 = Trip.create(name: "first trip", success: "good", species: "blue fish", body: "The blues were thick off the rock 100 yards from shore", user_id: 1)
trip2 = Trip.create(name: "second trip", success: "bad", species: "none", body: "Couldn't catch a cold", user_id: 1)



# create_table "trips", force: :cascade do |t|
#   t.string "name", null: false
#   t.string "success", null: false
#   t.string "species", null: false
#   t.text "body"
#   t.decimal "latitude"
#   t.decimal "longitude"
#   t.date "trip_date"
#   t.time "trip_time"
#   t.bigint "user_id", null: false
#   t.boolean "private"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_trips_on_user_id"
# end