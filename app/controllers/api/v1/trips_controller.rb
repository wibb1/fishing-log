class Api::V1::TripsController < ApiController
  def index
    if params[:filter_for_shared]
      trips=Trips.all.map{ |trip| 
        if trip.shared
          trip
        end
        }
    else 
     trips = current_user.trips
    end
  
    render json: { trips: serialized_data(trips, TripSerializer, current_user) }
  end

  def show
    binding.pry
    render json: Trip.find(params[:id]), serializer: TripShowSerializer
  end

  def search
    @trips = Trip.where("ILIKE ?", "%#{params['search_string']}%")
    render json: @trips
  end

  private

  def serialized_data(data, serializer, scope)
    ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer, scope: current_user)
  end

end