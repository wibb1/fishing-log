class TripsController < ApplicationController
  
  def index
  end

  def new
    @trip = Trip.new
    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
  end

  def edit
    @trip= Trip.find(params[:id])
  end

  def update
    @trip= Trip.find(params[:id])
    @article.update(title: params[:article][:title], description: params[:article][:description])
    redirect_to "/trips/#{@trip.id}"
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:notice] = "Trip added successfully"
      redirect_to @trips
    else
      flash.now[:error] = @trip.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update

  end

  private

  def trip_params
    params.require(:trip).permit(:name, :success, :species, :body, :latitude, :longitude, :trip_time, :shared)
  end
end
