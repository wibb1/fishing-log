class Api::V1::TripsController < ApiController
  def index
    if params[:filter_for_shared]
      trips = Trip.all
    else 
      trips = current_user.trips
    end
    
    render json: { user: current_user, trips: serialized_data(trips, TripSerializer, current_user) }
  end

  def show
    render json: Trip.find(params[:id]), serializer: TripShowSerializer
    #Both of these show data at the api/v1/trips/1 endpoint
     #trip = Trip.find(params[:id])
     #render json: { user: current_user, trip: serialized_data(trip, TripSerializer, current_user)  }
  end

  def search
    trips = Trip.where("ILIKE ?", "%#{params['search_string']}%")
    render json: @trips
  end

  private

  def serialized_data(data, serializer, scope)
    ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer, scope: current_user)
  end

end