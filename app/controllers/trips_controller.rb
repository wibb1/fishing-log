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
#####################################################
#####################################################
  def create
    start_date = trip_params["date"]
    text_date_time = trip_params["date"] + "T" + trip_params["time"]
    start_DateTime = DateTime.strptime(text_date_time, "%Y-%m-%dT%H:%M").getutc.to_s
    end_DateTime_hour = DateTime.strptime(text_date_time, "%Y-%m-%dT%H:%M").getutc.advance(:hours 1).to_s
    end_DateTime_day = DateTime.strptime(text_date_time, "%Y-%m-%dT%H:%M").getutc.advance(:days 1).to_s
    binding.pry ###check for proper time handling (zone)
    @trip = Trip.new()
    @trip.name = trip_params["name"] 
    @trip.success = trip_params["success"]
    @trip.species = trip_params["species"]
    @trip.body = trip_params["body"]
    @trip.latitude = trip_params["latitude"]
    @trip.longitude = trip_params["longitude"]   
    @trip.date = trip_params["date"]
    @trip.time = trip_params["time"]
    @trip.user = current_user
    @trip.shared = trip_params["shared"]
    binding.pry ##check that the variables are included 
    if @trip.save
      notices.push("Trip")
      binding.pry
      create_weather(start_DateTime, end_DateTime_hour, @trip.latitude, @trip.longitude, @trip.id)
      binding.pry ##check @weather before save
        if @weather.save
          notices.push("Weather")
        else
          errors.push(@weather.errors)
        end
      create_tide(start_DateTime, end_DateTime_day, @trip.id)
      binding.pry ##check @tide before save
        if @tide.save
          notices.push("Tide")
        else
          errors.push(@tide.errors)
        end
      create_astro(start_DateTime, end_DateTime_day, @trip.id)
      binding.pry ##check @astro before save
        if @astro.save
          notices.push("Astro")
        else
          errors.push(@astro.errors)
        end
    else
      errors.push(@trip.errors)
      errors = @trip.errors.full_messages.to_sentence
    end  
    if errors.length > 0
      flash[errors].full_messages.to_sentence
      binding.pry #check errors
      render :new
    binding.pry
  end
########################################
########################################
  def create_weather(start_DateTime, end_DateTime_hour, trip_latitude, trip_longitude, trip_id)
    weather_request = 'airTemperature,pressure,cloudCover,currentDirection,currentSpeed,gust,humidity,seaLevel,visibility,windDirection,windSpeed'

    api_key = ENV["STORMGLASS_API_KEY"]
    weather_response = Faraday.get("https://api.stormglass.io/v2/weather/point?lat=#{trip_latitude}&lng=#{trip_longitude}&start=#{start_DateTime}&end=#{end_DateTime_hour}&source=#{"noaa"}&params=#{weather_request}") do |req|  
      req.headers["Authorization"] = api_key
    end

    weather_parsed_response = JSON.parse(weather_response.body)
    data = weather_parsed_response["hours"][0]
    binding.pry ##view parsed data
    airTemperature = ((data["airTemperature"]["noaa"])*(9/5+32)).round(0).to_s
    pressure = (data["pressure"]["noaa"]*0.03).round(2).to_s
    cloudCover = (data["cloudCover"]["noaa"]).round(2).to_s
    gust = (data["gust"]["noaa"]*2.237).round(2).to_s
    humidity = data["humidity"]["noaa"].to_s
    visibility = data["visibility"]["noaa"].to_s
    windDirection = data["windDirection"]["noaa"].to_s
    windSpeed = (data["windSpeed"]["noaa"]*2.237).round(2).to_s
    
    @weather = Weather.new(time: start_DateTime, date: end_DateTime_hour, airTemperature: airTemperature, pressure: pressure, cloudCover: cloudCover, visibility: visibility, gust: gust,humidity: humidity,  windDirection: windDirection, windSpeed: windSpeed, trip_id: trip_id)
    binding.pry ##view data before create
  end
###########################
###########################
  def create_tide(start_DateTime, end_DateTime_day, trip_latitude, trip_longitude, trip_id)
    time_start = start_time.strftime("%Y-%m-%d")
    tide_end_time = start_time.advance(days: 1)
    tide_time_end = tide_end_time.strftime("%Y-%m-%d")
    api_key = ENV["STORMGLASS_API_KEY"]
    tide_url = "https://api.stormglass.io/v2/tide/extremes/point?lat=#{trip_latitude}&lng=#{trip_longitude}&start=#{start_DateTime}&end=#{end_DateTime_day}"
    tide_response = Faraday.get(tide_url) do |req| 
      req.headers["Authorization"] = api_key
    end

    tide_parsed_response = JSON.parse(tide_response.body)
    tide_data = tide_parsed_response["data"]
    binding.pry ##check the response to see if it came through
    first_type = tide_data[0]["type"]
    first_height = (tide_data[0]["height"]*3.28).round(2).to_s
    first_time = DateTime.strptime(tide_data[0]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")

    second_type = (tide_data[1]["height"]*3.28).round(2)
    second_time = DateTime.strptime(tide_data[1]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    second_height = (tide_data[0]["height"]*3.28).round(2).to_s
    third_type = (tide_data[2]["height"]*3.28).round(2)
    third_time = DateTime.strptime(tide_data[2]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    third_height = (tide_data[0]["height"]*3.28).round(2).to_s
    fourth_type = (tide_data[3]["height"]*3.28).round(2)
    fourth_time = DateTime.strptime(tide_data[3]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    fourth_height = (tide_data[0]["height"]*3.28).round(2).to_s

    @tide = Tide.new(date: start_time, first_type: first_type, first_time: first_time, second_type: second_type, second_time: second_time, third_type: third_type, third_time: third_time, fourth_type: fourth_type, fourth_time: fourth_time, trip_id: trip_id)
  end

  def create_astro(start_DateTime, end_DateTime_day, trip_latitude, trip_longitude, trip_id)
    astro_request = "astronomicalDawn,astronomicalDusk,civilDawn,civilDusk,moonFraction,moonPhase,moonrise,moonset,sunrise,sunset,time"
    api_key = ENV["STORMGLASS_API_KEY"]
    astro_url = "https://api.stormglass.io/v2/astronomy/point?lat=#{trip_latitude}&lng=#{trip_longitude}&start=#{start_DateTime}&end=#{end_DateTime_day}&params=#{astro_request}"
    astro_response = Faraday.get(astro_url) do |req| 
      req.headers["Authorization"] = api_key
    end

    astro_parsed_response = JSON.parse(astro_response.body)

    astro_data = astro_parsed_response["data"]
    binding.pry ##check the parsed data for values
    astronomicalDawn = DateTime.strptime(astro_data[0]["astronomicalDawn"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    astronomicalDusk = DateTime.strptime(astro_data[0]["astronomicalDusk"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    civilDawn = DateTime.strptime(astro_data[0]["civilDawn"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    civilDusk = DateTime.strptime(astro_data[0]["civilDusk"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    moonFraction = (astro_data[0]["moonFraction"]).round(2).to_s
    moonPhase = astro_data[0]["moonPhase"]["closest"]["text"].to_s
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
    params.require(:trip).permit(:name, :success, :species, :body, :latitude, :longitude, :date, :time, :shared)
  end

end
