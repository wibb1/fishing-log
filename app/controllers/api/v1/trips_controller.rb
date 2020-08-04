class Api::V1::TripsController < ApiController
  def index
    render json: Trip.all
    #render json: user, serializer: UserSerializer
    #binding.pry
  end

  def show
    trip = Trip.find(params[:id])
    #render json: user, serializer: UserSerializer
  end
end