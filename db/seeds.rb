# users
Trip.destroy_all
User.destroy_all
Tide.destroy_all
Astro.destroy_all
Weather.destroy_all

user1 = User.create!(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")
user2 = User.create!(email: "apple@aol.com", password: "123456", username: "Johny", first_name: "John", last_name: "Apple")

# trips
trip1 = Trip.create!(date: "05-20-2020", time: "08:45", latitude: 41.59, longitude: -70.81, success: "Good", species: "bluefish", user_id: user1.id, shared: false, name: "First trip of the season", body: "The blues were thick off the rock 100 yards from shore. If your bait managed to get through them then you had a shot at a bass. We switched to a heavier sinker to get down a little quicker and it helped. Blues are fun but you lose a lot of gear when you are trying to get bass")
trip2 = Trip.create!(date: "06-20-2020", time: "08:45", latitude: 41.59, longitude: -70.84, success: "Bad", species: "striped bass", user_id: user1.id, shared: true, name: "Second Trip of the season", body: "We couldn't catch a cold today. This is usally a great spot but the bright sun early in the season made the fish skittish. Fishing is still better than work and it is always nice to get out on the boat but it is better when you are catching.")
trip3 = Trip.create!(date: "06-20-2020", time: "08:45", latitude: 41.59, longitude: -70.843, success: "Good", species: "bluefish", user_id: user2.id, shared: true, name:"First trip", body: "Trolling for blues and my son and I had a ball. Several double hookups on a single troll. Perfect eating size too, about 15-20 inches. We had a blast trolling light tackle, tried casting for them but they seemed to be spread out along the shore. Not sure what they were after but it is a spot to go back to.")
trip4 = Trip.create!(date: "07-20-2020", time: "08:45", latitude: 41.59, longitude: -70.843, success: "Bad", species: "fluke", user_id: user2.id, shared: false, name: "Fluke Fishing", body: "We had a tough day trying to get some fluke. This is one of 5 or 6 spots. We caught some small sea bass but were really after fluke and the sea bass were all small. Maybe next time. Fluke are getting harder and harder to find around here, not sure what is going on but fishing for them has become a real challenge.")

# trip5 = Trip.create!(name: "Woods Hole Trip - September", success: "Good", species: "blue fish", trip_time: DateTime.new(2020,9,20,3,45,0), text_date: DateTime.new(2020,9,20,3,45,0).strftime("%m-%d-%Y %H:%M"),body: "Fun night chasing the bass inside the hole. Had lots of great luck chunking fresh pogies after dark. Nice night for a boat ride and the hole is a lot calmer after dark.", latitude: 41.52, longitude: -70.70, user_id: user1.id, shared: false)

# trip6 = Trip.create!(name: "Woods Hole Trip - September", success: "Good", species: "blue fish", trip_time: DateTime.new(2020,10,13,9,0,0), text_date: DateTime.new(2020,10,13,9,0,0).strftime("%m-%d-%Y %H:%M"),body: "Fun night chasing the bass inside the hole. Had lots of great luck chunking fresh pogies after dark. Nice night for a boat ride and the hole is a lot calmer after dark.", latitude: 41.52, longitude: -70.70, user_id: user1.id, shared: false)

# simple weather
weather1 = Weather.create!(date: "05-20-2020", time: "08:45", airTemperature: "54", pressure: "29", cloudCover: "0.2", currentDirection: "0", currentSpeed: "5", gust: "15", humidity: "62", seaLevel: "0.95", visibility: "2", windDirection: "25", windSpeed: "5", trip_id: trip1.id)
weather2 = Weather.create!(date: "06-20-2020", time: "08:45", airTemperature: "54", pressure: "29", cloudCover: "0.2", currentDirection: "0", currentSpeed: "5", gust: "15", humidity: "62", seaLevel: "0.95", visibility: "2", windDirection: "25", windSpeed: "5", trip_id: trip2.id)
weather3 = Weather.create!(date: "06-20-2020", time: "08:45", airTemperature: "54", pressure: "29", cloudCover: "0.2", currentDirection: "0", currentSpeed: "5", gust: "15", humidity: "62", seaLevel: "0.95", visibility: "2", windDirection: "25", windSpeed: "5", trip_id: trip3.id)
weather4 = Weather.create!(date: "07-20-2020", time: "08:45", airTemperature: "54", pressure: "29", cloudCover: "0.2", currentDirection: "0", currentSpeed: "5", gust: "15", humidity: "62", seaLevel: "0.95", visibility: "2", windDirection: "25", windSpeed: "5", trip_id: trip4.id)

# simple tide

tide1 = Tide.create!(date: "05-20-2020", first_type: "low", first_height: "0.15", first_time: "05-20-2020 04:25", second_type: "high", second_height: "2.5", second_time: "05-20-2020 10:15", third_type: "low", third_height: "0.15", third_time: "05-20-2020 16:05", fourth_type: "high", fourth_height: "2.5", fourth_time: "05-20-2020 21:00", trip_id: trip1.id)
tide2 = Tide.create!(date: "06-20-2020", first_type: "low", first_height: "0.15", first_time: "06-20-2020 04:25", second_type: "high", second_height: "2.5", second_time: "06-20-2020 10:15", third_type: "low", third_height: "0.15", third_time: "06-20-2020 16:05", fourth_type: "high", fourth_height: "2.5", fourth_time: "06-20-2020 21:00", trip_id: trip2.id)
tide3 = Tide.create!(date: "06-20-2020", first_type: "low", first_height: "0.15", first_time: "06-20-2020 04:25", second_type: "high", second_height: "2.5", second_time: "06-20-2020 10:15", third_type: "low", third_height: "0.15", third_time: "06-20-2020 16:05", fourth_type: "high", fourth_height: "2.5",fourth_time: "06-20-2020 21:00", trip_id: trip3.id)
tide4 = Tide.create!(date: "07-20-2020", first_type: "low", first_height: "0.15", first_time: "07-20-2020 04:25", second_type: "high", second_height: "2.5", second_time: "07-20-2020 10:15", third_type: "low", third_height: "0.15", third_time: "07-20-2020 16:05", fourth_type: "high", fourth_height: "2.5", fourth_time: "07-20-2020 21:00:", trip_id: trip4.id)

astro1 = Astro.create!(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: "0.5", moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: "06-20-2020", trip_id: trip1.id)
astro2 = Astro.create!(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: "0.3", moonPhase: "Three Quarter", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: "06-20-2020", trip_id: trip2.id)
astro3 = Astro.create!(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: "0.25", moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: "06-20-2020", trip_id: trip3.id)
astro4 = Astro.create!(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: "0.3", moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: "07-20-2020", trip_id: trip4.id)
