class Api::V1::TripsController < ApiController
  def index
    render json: { user: current_user, trips: current_user.trips }
  end

  def show
    trip = Trip.find(params[:id])
    render json: { user: current_user, trip: trip }
  end
end