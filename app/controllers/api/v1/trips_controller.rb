class Api::V1::TripsController < ApiController
  def index
    render json: current_user.trips
  end
end