user1 = User.create!(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")

user2 = User.create!(email: "apple@aol.com", password: "123456", username: "Johny", first_name: "John", last_name: "Apple")

trip1 = Trip.create!(name: "Tommy's first trip", success: "good", species: "blue fish", body: "Tommy - The blues were thick off the rock 100 yards from shore", latitude: 41.595, longitude: -70.81,  user_id: User.first.id)

trip2 = Trip.create!(name: "Tommy's second trip", success: "bad", species: "none", body: "Tommy - Couldn't catch a cold", latitude: 41.59, longitude: -70.843, user_id: User.first.id)

trip2 = Trip.create!(name: "Johny's first trip", success: "Good", species: "none", body: "Johny - Trolling for blues and My son and I had a ball", latitude: 41.59, longitude: -70.843, user_id: User.second.id)

trip2 = Trip.create!(name: "Johny's second trip", success: "bad", species: "none", body: "Johny - Couldn't catch a cold", latitude: 41.59, longitude: -70.843, user_id: User.second.id)


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