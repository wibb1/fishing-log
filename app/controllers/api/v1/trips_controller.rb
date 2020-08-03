classApi::TripsController < ApiController
  def index
    render json: Trip.all
  end
end