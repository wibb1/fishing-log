require 'rails_helper'

RSpec.describe Api::V1::TripsController, type: :controller do
  describe "GET#Index" do
    let!(:user1) {FactoryBot.create(:user)}
  
    time1 = DateTime.new(2020,6,20,5,6,30)

    let!(:trip1) {FactoryBot.create(:trip, user_id: user1.id, trip_time: time1, text_date: time1.strftime("%m-%d-%Y %H:%M"))}

    let!(:astro1) {FactoryBot.create(:astro, trip_id: trip1.id)}
    let!(:tide1) {FactoryBot.create(:tide, trip_id: trip1.id)}
    let!(:weather1) {FactoryBot.create(:weather, trip_id: trip1.id)}


    let!(:user2) {FactoryBot.create(:user)}

    let!(:trip2) {FactoryBot.create(:trip, user_id: user2.id, trip_time: DateTime.new(2020,5,20,8,45,0), text_date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"))}

    let!(:trip3) {FactoryBot.create(:trip, user_id: user1.id, trip_time: DateTime.new(2020,5,20,8,45,0), text_date: DateTime.new(2020,5,20,8,45,0).strftime("%m-%d-%Y %H:%M"))}


    it "returns a status of 200" do
      
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
    let!(:user1) {FactoryBot.create(:user)}
    let!(:trip1) {FactoryBot.create(:trip, user_id: user1.id)}
    let!(:user2) {FactoryBot.create(:user)}
    let!(:trip2) {FactoryBot.create(:trip, user_id: user2.id)}
    let!(:trip3) {FactoryBot.create(:trip, user_id: user1.id)}

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