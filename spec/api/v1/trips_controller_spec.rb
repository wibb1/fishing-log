require 'rails_helper'

RSpec.describe Api::V1::TripsController, type: :controller do
  describe "GET#Index" do
    # users
    user1 = User.create(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")
    user2 = User.create(email: "apple@aol.com", password: "123456", username: "Johny", first_name: "John", last_name: "Apple")

    # trips
    trip1 = Trip.create(name: "First trip of the season", success: "good", species: "blue fish", trip_time: DateTime.new(2020,5,20,8,45,0), text_date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "The blues were thick off the rock 100 yards from shore.  If your bait managed to get through them then you had a shot at a bass.  We switched to a heavier sinker to get down a little quicker and it helped.  Blues are fun but you lose a lot of gear when you are trying to get bass", latitude: 41.595, longitude: -70.81,  user_id: user1.id, shared: false)

    trip2 = Trip.create(name: "Second Trip of the season", trip_time: DateTime.new(2020,6,20,8,45,0),text_date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"), success: "bad", species: "none", body: "We couldn't catch a cold today.  This is usally a great spot but the bright sun early in the season made the fish skittish.  Fishing is still better than work and it is always nice to get out on the boat but it is better when you are catching.", latitude: 41.59, longitude: -70.843, user_id: user1.id, shared: true)

    trip3 = Trip.create(name: "First trip", success: "Good", species: "blue fish", trip_time: DateTime.new(2020,6,20,8,45,0), text_date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "Trolling for blues and my son and I had a ball. Several double hookups on a single troll.  Perfect eating size too, about 15-20 inches.  We had a blast trolling light tackle, tried casting for them but they seemed to be spread out along the shore.  Not sure what they were after but it is a spot to go back to.", latitude: 41.59, longitude: -70.843, user_id: user2.id, shared: true)

    trip4 = Trip.create(name: "Fluke Fishing", success: "bad", species: "fluke", trip_time: DateTime.new(2020,7,20,8,45,0), text_date: DateTime.new(2020,7,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "We had a tough day trying to get some fluke.  This is one of 5 or 6 spots.  We caught some small sea bass but were really after fluke and the sea bass were all small.  Maybe next time.  Fluke are getting harder and harder to find around here, not sure what is going on but fishing for them has become a real challenge.", latitude: 41.59, longitude: -70.843, user_id: User.second.id, shared: false)

    # simple weather
    weather1 = Weather.create(time: DateTime.new(2020,5,20,8,45,0), text_date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"), airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip1.id)

    weather2 = Weather.create(time: DateTime.new(2020,6,20,8,45,0), text_date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"),airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip2.id)

    weather3 = Weather.create(time: DateTime.new(2020,6,20,8,45,0), text_date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"),airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip3.id)

    weather4 = Weather.create(time: DateTime.new(2020,7,20,8,45,0), text_date: DateTime.new(2020,7,20,8,45,0).strftime("%m-%d-%Y %H:%M"),airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip4.id)

    # simple tide
    tide1 = Tide.create(date: Date.new(2020,5,20), first_type: -3, first_time: DateTime.new(2020,5,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,5,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,5,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,5,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip1.id)

    tide2 = Tide.create(date:Date.new(2020,6,20), first_type: -3, first_time: DateTime.new(2020,6,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,6,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,6,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,6,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip2.id)

    tide3 = Tide.create(date:Date.new(2020,6,20), first_type: -3, first_time: DateTime.new(2020,6,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,6,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,6,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,6,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip3.id)

    tide4 = Tide.create(date:Date.new(2020,7,20), first_type: -3, first_time: DateTime.new(2020,7,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,7,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,7,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,7,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip4.id)

    #astrological
    astro1 = Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.5, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", time: DateTime.new(2020,7,20,21,00), trip_id: trip1.id)

    astro2 = Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.3, moonPhase: "Three Quarter", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", time: DateTime.new(2020,7,20,21,00), trip_id: trip2.id)

    astro3 = Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.25, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", time: DateTime.new(2020,7,20,21,00), trip_id: trip3.id)

    astro4 = Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.3, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", time: DateTime.new(2020,7,20,21,00), trip_id: trip4.id)


    it "returns a status of 200" do
      binding.pry
      sign_in user1
      
      get :index

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      sign_out user1
    end

    it "returns all the user1 trips in the database" do
    
      sign_in user1
      
      get :index

      returned_json = JSON.parse(response.body)
      expect(returned_json["trips"][0]["name"]).to eq(trip1.name)
      
      sign_out user1
    end

    it "does not include the trips for user2" do
      sign_in user1
      
      get :index

      returned_json = JSON.parse(response.body)
      expect(returned_json["trips"][1]).not_to include(trip2.name)

      sign_out user1
    end
  end

  describe "GET#Show" do

    it "returns a status of 200" do
      sign_in user1
      
      get :show, params: { id: trip1.id }

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      sign_out user1
    end

    it "returns json of /trips/:id" do
      sign_in user1

      get :show, params: { id: trip1.id }
      returned_json = JSON.parse(response.body)

      expect(returned_json["trip"]["name"]).to eq(trip1.name)

      sign_out user1
    end
  end

end