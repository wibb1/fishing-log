require 'rails_helper'

  RSpec.describe Api::V1::TripsController, type: :controller do
    describe "GET#Index" do
      let!(:user1) {FactoryBot.create(:user)}
      
      # let!(:trip1) {{}}

      it "returns a status of 200" do
binding.pry
        get :index

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"
      end

      it "returns all the products in the database" do
        get :index

        returned_json = JSON.parse(response.body)
        expect(returned_json["trips"][0]["name"]).to eq(trip1.name)
        expect(returned_json["trips"][0]["body"]).to eq(trip1.body)
      end
    end
  end