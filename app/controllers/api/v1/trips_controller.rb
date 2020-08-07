class Api::V1::TripsController < ApiController
  def index
<<<<<<< HEAD
    binding.pry
    render json: Trip.all
    #render json: user, serializer: UserSerializer
    #binding.pry
  end

  def show
    trip = Trip.find(params[:id])
    #render json: user, serializer: UserSerializer
=======
    render json: current_user.trips
>>>>>>> master
  end
end