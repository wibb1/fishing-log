class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :username, :trips

  def trips
    self.object.trips.map do |trip| 
      if :id == trip.user_id 
        name: trip.name,
        id: trip.id, 
        sucess: trip.success, 
        species: trip.species, 
        body: trip.body, 
        latitude: trip.latitude, 
        longitude: trip.longitude, 
        trip_date: trip.trip_date , 
        trip_time: trip.trip_time, 
        private: trip.private
        user_id: trip.user_id
      end
    end
  end
end

# t.string "email", default: "", null: false
# t.string "encrypted_password", default: "", null: false
# t.string "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "first_name", null: false
# t.string "last_name", null: false
# t.string "username", null: false
# t.index ["email"], name: "index_users_on_email", unique: true
# t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true