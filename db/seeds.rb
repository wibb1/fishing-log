user1 = User.create!(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")

user2 = User.create!(email: "apple@aol.com", password: "123456", username: "Johny", first_name: "John", last_name: "Apple")

trip1 = Trip.create!(name: "Tommy's first trip shared", success: "good", species: "blue fish", body: "Tommy - The blues were thick off the rock 100 yards from shore", latitude: 41.595, longitude: -70.81,  user_id: User.first.id, shared: true)

trip2 = Trip.create!(name: "Tommy's second trip -private", success: "bad", species: "none", body: "Tommy - Couldn't catch a cold", latitude: 41.59, longitude: -70.843, user_id: User.first.id, shared: false)

trip2 = Trip.create!(name: "Johny's first trip - shared", success: "Good", species: "none", body: "Johny - Trolling for blues and My son and I had a ball", latitude: 41.59, longitude: -70.843, user_id: User.second.id, shared: true)

trip2 = Trip.create!(name: "Johny's second trip - private", success: "bad", species: "blue fish", body: "Johny - Couldn't catch a cold", latitude: 41.59, longitude: -70.843, user_id: User.second.id, shared: false)
