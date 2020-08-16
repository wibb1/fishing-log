class TripsController < ApplicationController
  require 'date'
  require 'faraday'

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
      redirect_to "/trips/react/#{@trip.id}"
    else
      render 'edit'
    end
  end

  def destroy
    Trip.destroy
    redirect_to "/trips"
  end

  def create
    binding.pry
    start_time = DateTime.strptime(trip_params["trip_time"], "%Y-%m-%dT%H:%M")
          
    @trip = Trip.new()
    @trip.trip_time = start_time
    binding.pry
    @trip.text_date = start_time.strftime("%m-%d-%Y %H:%M")
    @trip.user = current_user
    binding.pry
    if @trip.save
      flash[:notice] = "Trip added successfully"
      redirect_to '/trips/react'
      binding.pry
      create_weather(start_time, @trip.id)
      create_tide(start_time, @trip.id)
      create_astro(start_time, @trip.id)

    else
      flash.now[:error] = @trip.errors.full_messages.to_sentence
      render :new
    end  
binding.pry
    if @tide.save
      flash[:notice] = "Tide added successfully"
    else
      flash.now[:error] = @tide.errors.full_messages.to_sentence
    end
    binding.pry
    # the below should move back to create and out of this helper method
    
    if @weather.save
      flash[:notice] = "Weather added successfully"
    else
      flash.now[:error] = @weather.errors.full_messages.to_sentence
      render :new
    end
    binding.pry
    if @astro.save
      flash[:notice] = "astro added successfully"
    else
      flash.now[:error] = @astro.errors.full_messages.to_sentence
    end
    binding.pry
  end

  def create_weather(start_time, trip_id)
    weather_request = 'airTemperature,pressure,cloudCover,currentDirection,currentSpeed,gust,humidity,seaLevel,visibility,windDirection,windSpeed'
    time_start = start_time.strftime("%Y-%m-%d")
    end_time = start_time.advance(hours: 1)
    time_end = end_time.strftime("%Y-%m-%d")
    api_key = ENV["STORMGLASS_API_KEY"]
    weather_response = Faraday.get("https://api.stormglass.io/v2/weather/point?lat=#{@trip.latitude}&lng=#{@trip.longitude}&start=#{time_start}&end=#{time_end}&source=#{"noaa"}&params=#{weather_request}") do |req|  
      req.headers["Authorization"] = api_key
    end

    weather_parsed_response = JSON.parse(weather_response.body)
    
    data = weather_parsed_response["hours"][0]
    binding.pry
    text_date = start_time.strftime("%m-%d-%Y %H:%M")
    airTemperature = ((data["airTemperature"]["noaa"])*(9/5+32)).round(0)
    pressure = (data["pressure"]["noaa"]*0.03).round(2)
    cloudCover = (data["cloudCover"]["noaa"]).round(2)
    gust = (data["gust"]["noaa"]*2.237).round(2)
    humidity = data["humidity"]["noaa"]
    visibility = data["visibility"]["noaa"]
    windDirection = data["windDirection"]["noaa"]
    windSpeed = (data["windSpeed"]["noaa"]*2.237).round(2)
    
    @weather = Weather.new(time: start_time, text_date: text_date, airTemperature: airTemperature, pressure: pressure, cloudCover: cloudCover, visibility: visibility, gust: gust,humidity: humidity,  windDirection: windDirection, windSpeed: windSpeed)
    
    @weather.trip_id = trip_id
    


  end

  def create_tide(start_time, trip_id)
    time_start = start_time.strftime("%Y-%m-%d")
    tide_end_time = start_time.advance(days: 1)
    tide_time_end = tide_end_time.strftime("%Y-%m-%d")
    api_key = ENV["STORMGLASS_API_KEY"]
    tide_url = "https://api.stormglass.io/v2/tide/extremes/point?lat=#{@trip.latitude}&lng=#{@trip.longitude}&start=#{time_start}&end=#{tide_time_end}"
    tide_response = Faraday.get(tide_url) do |req| 
      req.headers["Authorization"] = api_key
    end

    tide_parsed_response = JSON.parse(tide_response.body)

    tide_data = tide_parsed_response["data"]
    binding.pry
    first_type = (tide_data[0]["height"]*3.28).round(2)
    first_time = DateTime.strptime(tide_data[0]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    second_type = (tide_data[1]["height"]*3.28).round(2)
    second_time = DateTime.strptime(tide_data[1]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    third_type = (tide_data[2]["height"]*3.28).round(2)
    third_time = DateTime.strptime(tide_data[2]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")

    if tide_data[3] != nil
      fourth_type = (tide_data[3]["height"]*3.28).round(2)
      fourth_time = DateTime.strptime(tide_data[3]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
      @tide = Tide.new(date: start_time, first_type: first_type, first_time: first_time, second_type: second_type, second_time: second_time, third_type: third_type, third_time: third_time, fourth_type: fourth_type, fourth_time: fourth_time)
    else
      @tide = Tide.new(date: start_time, first_type: first_type, first_time: first_time, second_type: second_type, second_time: second_time, third_type: third_type, third_time: third_time)
    end

    @tide.trip_id = trip_id
  end

  def create_astro(start_time, trip_id)
    time_start = start_time.strftime("%Y-%m-%d")
    astro_end_time = start_time.advance(days: 1)
    astro_time_end = astro_end_time.strftime("%Y-%m-%d")
    astro_request = "astronomicalDawn,astronomicalDusk,civilDawn,civilDusk,moonFraction,moonPhase,moonrise,moonset,sunrise,sunset,time"
    api_key = ENV["STORMGLASS_API_KEY"]
    astro_url = "https://api.stormglass.io/v2/astronomy/point?lat=#{@trip.latitude}&lng=#{@trip.longitude}&start=#{time_start}&end=#{astro_time_end}&params=#{astro_request}"
    astro_response = Faraday.get(astro_url) do |req| 
      req.headers["Authorization"] = api_key
    end

    astro_parsed_response = JSON.parse(astro_response.body)

    astro_data = astro_parsed_response["data"]
    binding.pry
    astronomicalDawn = DateTime.strptime(astro_data[0]["astronomicalDawn"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    astronomicalDusk = DateTime.strptime(astro_data[0]["astronomicalDusk"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    civilDawn = DateTime.strptime(astro_data[0]["civilDawn"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    civilDusk = DateTime.strptime(astro_data[0]["civilDusk"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    moonFraction = (astro_data[0]["moonFraction"]).round(2)
    moonPhase = astro_data[0]["moonPhase"]["closest"]["text"]
    moonrise = DateTime.strptime(astro_data[0]["moonrise"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    moonset = DateTime.strptime(astro_data[0]["moonset"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    sunrise = DateTime.strptime(astro_data[0]["sunrise"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    sunset = DateTime.strptime(astro_data[0]["sunset"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    time = DateTime.strptime(astro_data[0]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")

    @astro = Astro.new(astronomicalDawn: astronomicalDawn, astronomicalDusk: astronomicalDusk, civilDawn: civilDawn, civilDusk: civilDusk, moonFraction: moonFraction, moonPhase: moonPhase, moonrise: moonrise, moonset: moonset, sunrise: sunrise, sunset: sunset, time: time)
    binding.pry
    @astro.trip_id = trip_id


  end

  private 

  def trip_params
    params.require(:trip).permit(:name, :success, :species, :body, :latitude, :longitude, :trip_time, :shared)
  end

end
