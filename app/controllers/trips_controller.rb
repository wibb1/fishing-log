class TripsController < ApplicationController
  
  def index
  end

  def new
    @trip = Trip.new
    @trip.user = current_user
    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
  end
  
  def edit
    @trip = Trip.find(params[:id])
    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
  end
  
  def update
    if @trip.update(trip_params)
      redirect_to "/trips/#{trip.id}"
    else
      render 'edit'
    end
  end

   def destroy
    Trip.destroy
    redirect_to "/trips"
  end

  def create
    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    if @trip.save
      flash[:notice] = "Trip added successfully"
      redirect_to '/trips'
    else
      flash.now[:error] = @trip.errors.full_messages.to_sentence
      render :new
    end
  end

  
  private

  def trip_params
    params.require(:trip).permit(:name, :success, :species, :body, :latitude, :longitude, :trip_time, :shared)
  end
end
