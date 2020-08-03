user1 = User.create(first_name: "Tom", last_name: "Thumb", password: "apple", email: "thumb@aol.com")
trip1 = Trip.create(name: "first trip", success: "good", species: "blue fish", body: "The blues were thick off the rock 100 yards from shore", user_id: user1.id)
trip2 = Trip.create(name: "second trip", success: "bad", species: "none", body: "Couldn't catch a cold", user_id: user1.id)
