class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :success, :species, :body, :user_id, :user_name

  def user_name
    "#{scope.first_name} #{scope.last_name}"
  end
end
# create_table "trips", force: :cascade do |t|
#   t.string "name", null: false
#   t.string "success", null: false
#   t.string "species", null: false
#   t.text "body"
#   t.decimal "latitude"
#   t.decimal "longitude"
#   t.time "trip_time"
#   t.bigint "user_id", null: false
#   t.boolean "private"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_trips_on_user_id"
# end
