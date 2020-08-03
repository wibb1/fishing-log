#user1 = User.create!(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")

#user2 = User.create!(email: "123@aol.com", password: "123456", username: "Tommy2", first_name: "Tom", last_name: "Thumb")

binding.pry
trip1 = Trip.create!(name: "first trip", success: "good", species: "blue fish", body: "The blues were thick off the rock 100 yards from shore", user_id: User.first.id)

trip2 = Trip.create!(name: "second trip", success: "bad", species: "none", body: "Couldn't catch a cold", user_id: User.second.id)
