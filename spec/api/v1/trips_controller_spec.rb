require 'rails-helper'

  Rspec.dexcribe Api::V1::TripsController, type: :controller do
    describe "GET#Index" do
      let!(:trip1) {FactoryBot.create(:trip)}
      let!(:trip2) {FactoryBot.create(:trip)}

      it "returns a status of 200" do
        get :index
        
        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"
      end

      it "returns all the products in the database" do
        get :index

        returned_json = JSON.parse(response.body)
        expect(returned_json["trips"][0]["name"]).to eq(product1.name)
        expect(returned_json["trips"][0]["body"]).to eq(product1.body)
        expect(returned_json["trips"][1]["name"]).to eq(product2.name)
        expect(returned_json["trips"][1]["body"]).to eq(product2.body)
      end
    end
  end