require 'rails_helper'

  RSpec.describe Api::V1::TripsController, type: :controller do
    describe "GET#Index" do
      let!(:user1) {FactoryBot.create(:user)}
      let!(:trip1) {FactoryBot.create(:trip, user_id: user1.id)}

      it "returns a status of 200" do

        get :index

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"
      end

      it "returns all the trips in the database" do
        get :index

        returned_json = JSON.parse(response.body)
        expect(returned_json[0]["name"]).to eq(trip1.name)
        expect(returned_json[0]["body"]).to eq(trip1.body)
      end
    end
  end