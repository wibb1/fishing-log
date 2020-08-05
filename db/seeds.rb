#user1 = User.create!(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")

#user2 = User.create!(email: "123@aol.com", password: "123456", username: "Tommy2", first_name: "Tom", last_name: "Thumb")

binding.pry
trip1 = Trip.create!(name: "first trip", success: "good", species: "blue fish", body: "The blues were thick off the rock 100 yards from shore", latitude: 41.595, longitutde: -70.81, trip_date: Time.new(2020,6,25) trip_time: Time.at12:00,  user_id: User.first.id)

trip2 = Trip.create!(name: "second trip", success: "bad", species: "none", body: "Couldn't catch a cold", latitude: 41.59, longitude: -70.843, user_id: User.second.id)


# t.string :name, null: false
# t.string :success, null: false
# t.string :species, null: false
# t.text :body
# t.decimal :latitude
# t.decimal :longitude
# t.date :trip_date
# t.time :trip_time
# t.belongs_to :user, null: false
# t.boolean :private, defalut: false