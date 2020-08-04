class Api::V1::TripsController < ApiController
  def index
    render json: Trip.all
  end
end