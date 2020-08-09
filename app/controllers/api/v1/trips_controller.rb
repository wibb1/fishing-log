class Api::V1::TripsController < ApiController
  def index
    render json: current_user.trips
  end

  def show
    product = Trip.find(params[:id])
    render json: trip, serializer: Trip
  end
end