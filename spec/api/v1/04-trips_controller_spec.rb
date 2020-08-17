require 'rails_helper'

RSpec.describe Api::V1::TripsController, type: :controller do
  describe "GET#Index" do

    let!(:user1) {User.create(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")}

    let!(:trip1) {Trip.create(name: "First trip of the season", success: "good", species: "blue fish", time: DateTime.new(2020,5,20,8,45,0), date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "The blues were thick off the rock 100 yards from shore.  If your bait managed to get through them then you had a shot at a bass.  We switched to a heavier sinker to get down a little quicker and it helped.  Blues are fun but you lose a lot of gear when you are trying to get bass", latitude: 41.595, longitude: -70.81,  user_id: user1.id, shared: true)}

    let!(:trip2) {Trip.create(name: "Second Trip of the season", time: DateTime.new(2020,6,20,8,45,0),date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"), success: "bad", species: "none", body: "We could not catch a cold today.  This is usally a great spot but the bright sun early in the season made the fish skittish.  Fishing is still better than work and it is always nice to get out on the boat but it is better when you are catching.", latitude: 41.59, longitude: -70.843, user_id: user1.id, shared: true)}

    let!(:weather1) {Weather.create(time: DateTime.new(2020,5,20,8,45,0), date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"), airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0, currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip1.id)}

    let!(:weather2) {Weather.create(time: DateTime.new(2020,6,20,7,30,1), date: DateTime.new(2020,6,20,7,30,1).strftime("%m-%d-%Y %H:%M"),airTemperature: 65, pressure: 40, cloudCover: 0.25, currentDirection: 10, currentSpeed: 10, gust: 20, humidity: 50, seaLevel: 0.9, visibility: 5, windDirection: 30, windSpeed: 10, trip_id: trip2.id)}

    let!(:tide1) {Tide.create(date: Date.new(2020,5,20), first_type: -3, first_time: DateTime.new(2020,5,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,5,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,5,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,5,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip1.id)}

    let!(:tide2) {Tide.create(date:Date.new(2020,6,20), first_type: -3, first_time: DateTime.new(2020,6,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,6,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,6,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,6,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip2.id)}

    let!(:astro1) {Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.5, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: DateTime.new(2020,7,20,21,00), trip_id: trip1.id)}

    let!(:astro2) {Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.3, moonPhase: "Three Quarter", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: DateTime.new(2020,7,20,21,00), trip_id: trip2.id)}

    let!(:user2) {User.create(email: "apple@aol.com", password: "123456", username: "Johny", first_name: "John", last_name: "Apple")}

    let!(:trip3) {Trip.create(name: "New trip", success: "Good", species: "blue fish", time: DateTime.new(2020,6,20,8,45,0), date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "Trolling for blues and my son and I had a ball. Several double hookups on a single troll.  Perfect eating size too, about 15-20 inches.  We had a blast trolling light tackle, tried casting for them but they seemed to be spread out along the shore.  Not sure what they were after but it is a spot to go back to.", latitude: 41.59, longitude: -70.843, user_id: user2.id, shared: true)}

    let!(:trip4) {Trip.create(name: "Fluke Fishing", success: "bad", species: "fluke", time: DateTime.new(2020,7,20,8,45,0), date: DateTime.new(2020,7,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "We had a tough day trying to get some fluke.  This is one of 5 or 6 spots.  We caught some small sea bass but were really after fluke and the sea bass were all small.  Maybe next time.  Fluke are getting harder and harder to find around here, not sure what is going on but fishing for them has become a real challenge.", latitude: 41.59, longitude: -70.843, user_id: user2.id, shared: false)}

    let!(:weather3) {Weather.create(time: DateTime.new(2020,6,20,8,45,0), date: DateTime.new(2020,6,20,8,45,0).strftime("%m-%d-%Y %H:%M"),airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip3.id)}

    let!(:weather4) {Weather.create(time: DateTime.new(2020,7,20,8,45,0), date: DateTime.new(2020,7,20,8,45,0).strftime("%m-%d-%Y %H:%M"),airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip4.id)}

    let!(:tide3) {Tide.create(date: Date.new(2020,6,20), first_type: -3, first_time: DateTime.new(2020,6,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,6,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,6,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,6,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip3.id)}

    let!(:tide4) {Tide.create(date: Date.new(2020,7,20), first_type: -3, first_time: DateTime.new(2020,7,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,7,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,7,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,7,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip4.id)}

    let!(:astro3) {Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.25, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: DateTime.new(2020,7,20,21,00), trip_id: trip3.id)}

    let!(:astro4) {Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.3, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: DateTime.new(2020,7,20,21,00), trip_id: trip4.id)}

    it "returns a status of 200 - trips_controller_spec - line 42" do
       
      sign_in user1
      
      get :index

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      sign_out user1
    end

    # it "returns user1 trips in the database - line 54" do
    
    #   sign_in user1
      
    #   get :index

    #   returned_json = JSON.parse(response.body)
   
    #   expect(returned_json["trips"]["trips"][0]["weather"]["id"]).to eq(weather1.id)
    #   expect(returned_json["trips"]["trips"][0]["tide"]["id"]).to eq(tide1.id)
    #   expect(returned_json["trips"]["trips"][0]["astro"]["id"]).to eq(astro1.id)
    #   expect(returned_json["trips"]["trips"][0]["user_id"]).to eq(user1.id)
      
    #   sign_out user1
    # end

    it "does not include the trips for user2 - line 71" do
      sign_in user1
      
      get :index

      returned_json = JSON.parse(response.body)
      expect(returned_json["trips"]["trips"][0]["name"]).not_to include(trip3.name)

      sign_out user1
    end
  end

  describe "GET#Show" do

    let!(:user1) {User.create(email: "thumb@aol.com", password: "123456", username: "Tommy", first_name: "Tom", last_name: "Thumb")}

    let!(:trip1) {Trip.create(name: "First trip of the season", success: "good", species: "blue fish", time: DateTime.new(2020,5,20,8,45,0), date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"), body: "The blues were thick off the rock 100 yards from shore.  If your bait managed to get through them then you had a shot at a bass.  We switched to a heavier sinker to get down a little quicker and it helped.  Blues are fun but you lose a lot of gear when you are trying to get bass", latitude: 41.595, longitude: -70.81,  user_id: user1.id, shared: false)}

    let!(:weather1) {Weather.create(time: DateTime.new(2020,5,20,8,45,0), date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"), airTemperature: 54, pressure: 29, cloudCover: 0.2, currentDirection: 0,currentSpeed: 5, gust: 15, humidity: 62, seaLevel: 0.95, visibility: 2, windDirection: 25, windSpeed: 5, trip_id: trip1.id)}

    let!(:tide1) {Tide.create(date: Date.new(2020,5,20), first_type: -3, first_time: DateTime.new(2020,5,20,4,25).strftime("%m-%d-%Y %H:%M"), second_type: +3, second_time: DateTime.new(2020,5,20,10,15).strftime("%m-%d-%Y %H:%M"), third_type: -3, third_time: DateTime.new(2020,5,20,16,05).strftime("%m-%d-%Y %H:%M"), fourth_type: +3, fourth_time: DateTime.new(2020,5,20,21,00).strftime("%m-%d-%Y %H:%M"), trip_id: trip1.id)}

    let!(:astro1) {Astro.create(astronomicalDawn: "06:30", astronomicalDusk: "06:30", civilDawn: "06:30", civilDusk: "06:30", moonFraction: 0.5, moonPhase: "Full", moonrise: "06:30", moonset: "06:30", sunrise: "06:30", sunset: "06:30", date: DateTime.new(2020,7,20,21,00), trip_id: trip1.id)}

    it "returns a status of 200 - line 95" do

      sign_in user1
      
      get :show, params: { id: trip1.id }

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      sign_out user1
    end

    it "returns json of /trips/react/:id - line 107" do
      sign_in user1

      get :show, params: { id: trip1.id }
      returned_json = JSON.parse(response.body)
      
      expect(returned_json["trip"]["name"]).to eq(trip1.name)
      expect(returned_json["trip"]["weather"]["id"]).to eq(weather1.id)
      expect(returned_json["trip"]["tide"]["id"]).to eq(tide1.id)
      expect(returned_json["trip"]["astro"]["id"]).to eq(astro1.id)
      expect(returned_json["trip"]["user_id"]).to eq(user1.id)
      
      sign_out user1
    end
  
  end

end