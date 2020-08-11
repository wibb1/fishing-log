class Api::V1::TripsController < ApiController
  def index
    render json: { user: current_user, trips: current_user.trips }
  end

  def show
    trip = Trip.find(params[:id])
    render json: { user: current_user, trip: trip }
  end

  # def create
  #   new_trip = Trip.new(trip_params)
  #   if new_trip.save
  #     render json: new_trip
  #   else
  #     render json: {errors: new_trip.errors.full_messages}
  #   end
  # end

  # private

  # def trip_params
  #   params.require(:trip).permit(:name, :success, :species, :body, :latitude, :longitude, :trip_time, :shared)
  # end 
end
