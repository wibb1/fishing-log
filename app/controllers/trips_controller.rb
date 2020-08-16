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
    if @trip.update(update_params)
      redirect_to "/trips/react/#{update_params[:id]}"
    else
      render 'edit'
    end
  end

  def destroy
    Weather.destroy(Trip.find(params[:id]).weather.id)
    Astro.destroy(Trip.find(params[:id]).astro.id)
    Tide.destroy(Trip.find(params[:id]).tide.id)
    Trip.destroy(params[:id])

    redirect_to "/trips/react"
  end
#####################################################
#####################################################
  def create
    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
    start_date = trip_params["date"]
    start_time = trip_params["time"]
    text_date_time = trip_params["date"] + "T" + trip_params["time"]
    parsed_time=Time.parse(text_date_time)

    start_DateTime = parsed_time.getutc.to_s
    end_DateTime_hour = parsed_time.advance(hours: 1).getutc.to_s
    end_DateTime_day = parsed_time.advance(days: 1).getutc.to_s

    @trip_new = Trip.new()
    @trip_new.name = trip_params["name"] 
    @trip_new.success = trip_params["success"]
    @trip_new.species = trip_params["species"]
    @trip_new.body = trip_params["body"]
    @trip_new.latitude = trip_params["latitude"]
    @trip_new.longitude = trip_params["longitude"]   
    @trip_new.date = trip_params["date"]
    @trip_new.time = trip_params["time"]
    @trip_new.user = current_user
    @trip_new.shared = trip_params["shared"]

    if parsed_time > Time.now()
      flash[:errors] = "Please enter a date and time that are less that the current time"
      @trip_new
      render :new
    else
      @notices = []
      @errors = []
      if @trip.save
        @notices.push("Trip")
        puts "***Trip successfully saved***"
        create_weather(start_DateTime, end_DateTime_hour, start_date, start_time)
          if @weather.save
            puts "***Weather successfully saved***"
          else
            Weather.destroy(trip_params.id.weather.id)
            Trip.destroy(trip_params.id)            
            flash[:errors] = @weather.errors.to_sentence
            render :new          
            puts "---#{@weather.errors.to_sentence}---"
          end
        create_tide(start_DateTime, end_DateTime_day, start_date)
          if @tide.save
            #flash[:notices] << "Tide"
            puts "***Tide successfully saved***"
          else
            Weather.destroy(trip_params.id.weather.id)
            Tide.destroy(trip_params.id.tide.id)
            Trip.destroy(trip_params.id)

            flash[:errors] = @tide.errors.to_sentence
            render :new
            puts "---#{@tide.errors.to_sentence}---"
          end
        create_astro(start_DateTime, end_DateTime_day, start_date)
          if @astro.save
            puts "***Astrological successfully saved***"
            redirect_to "/trips/react/#{@trip.id}"
          else
            Weather.destroy(trip_params.id.weather.id)
            Tide.destroy(trip_params.id.tide.id)
            Astro.destroy(trip_params.id.astro.id)
            Trip.destroy(trip_params.id)

            flash[:errors] = @astro.errors.to_sentence
            render :new
            puts "---#{@astro.errors.to_sentence}---"
          end
      end  
    end
  end
########################################
########################################
  def create_weather(start_DateTime, end_DateTime_hour, start_date, start_time)
    weather_request = 'airTemperature,pressure,cloudCover,currentDirection,currentSpeed,gust,humidity,seaLevel,visibility,windDirection,windSpeed'

    api_key = ENV["STORMGLASS_API_KEY"]
    weather_response = Faraday.get("https://api.stormglass.io/v2/weather/point?lat=#{@trip.latitude}&lng=#{@trip.longitude}&start=#{start_DateTime}&end=#{end_DateTime_hour}&source=#{"noaa"}&params=#{weather_request}") do |req|  
      req.headers["Authorization"] = api_key
    end

    weather_parsed_response = JSON.parse(weather_response.body)
    data = weather_parsed_response["hours"][0]

    airTemperature = ((data["airTemperature"]["noaa"])*9/5+32).round(0).to_s
    pressure = (data["pressure"]["noaa"]*0.03).round(2).to_s
    cloudCover = (data["cloudCover"]["noaa"]).round(2).to_s
    gust = (data["gust"]["noaa"]*2.237).round(2).to_s
    humidity = data["humidity"]["noaa"].to_s
    visibility = data["visibility"]["noaa"].to_s
    windDirection = data["windDirection"]["noaa"].to_s
    windSpeed = (data["windSpeed"]["noaa"]*2.237).round(2).to_s
    
    @weather = Weather.new(time: start_DateTime, date: end_DateTime_hour, airTemperature: airTemperature, pressure: pressure, cloudCover: cloudCover, visibility: visibility, gust: gust,humidity: humidity,  windDirection: windDirection, windSpeed: windSpeed, trip_id: @trip.id)
  end

  def create_tide(start_DateTime, end_DateTime_day, start_date)
    api_key = ENV["STORMGLASS_API_KEY"]
    tide_url = "https://api.stormglass.io/v2/tide/extremes/point?lat=#{@trip.latitude}&lng=#{@trip.longitude}&start=#{start_DateTime}&end=#{end_DateTime_day}"
    tide_response = Faraday.get(tide_url) do |req| 
      req.headers["Authorization"] = api_key
    end

    tide_parsed_response = JSON.parse(tide_response.body)
    tide_data = tide_parsed_response["data"]

    first_type = tide_data[0]["type"]
    first_height = (tide_data[0]["height"]*3.28).round(2).to_s
    first_time = DateTime.strptime(tide_data[0]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    second_type = (tide_data[1]["height"]*3.28).round(2)
    second_time = DateTime.strptime(tide_data[1]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    second_height = (tide_data[1]["height"]*3.28).round(2).to_s
    third_type = (tide_data[2]["height"]*3.28).round(2)
    third_time = DateTime.strptime(tide_data[2]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
    third_height = (tide_data[2]["height"]*3.28).round(2).to_s

    if tide_data[3]
      fourth_type = (tide_data[3]["height"]*3.28).round(2).to_s
      fourth_time = DateTime.strptime(tide_data[3]["time"], "%Y-%m-%dT%H:%M:%S%z").strftime("%m-%d-%Y %H:%M")
      fourth_height = (tide_data[3]["height"]*3.28).round(2).to_s
    end
    @tide = Tide.new(date: start_date, first_type: first_type, first_time: first_time, first_height: first_time, second_type: second_type, second_time: second_time, second_height: second_height, third_type: third_type, third_time: third_time, third_height: third_height, fourth_type: fourth_type, fourth_time: fourth_time, fourth_height: fourth_height, trip_id: @trip.id)
  end

  def create_astro(start_DateTime, end_DateTime_day, start_date)
    astro_request = "astronomicalDawn,astronomicalDusk,civilDawn,civilDusk,moonFraction,moonPhase,moonrise,moonset,sunrise,sunset,time"
    api_key = ENV["STORMGLASS_API_KEY"]
    astro_url = "https://api.stormglass.io/v2/astronomy/point?lat=#{@trip.latitude}&lng=#{@trip.longitude}&start=#{start_DateTime}&end=#{end_DateTime_day}&params=#{astro_request}"
    astro_response = Faraday.get(astro_url) do |req| 
      req.headers["Authorization"] = api_key
    end

    astro_parsed_response = JSON.parse(astro_response.body)

    astro_data = astro_parsed_response["data"]

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

    @astro = Astro.new(astronomicalDawn: astronomicalDawn, astronomicalDusk: astronomicalDusk, civilDawn: civilDawn, civilDusk: civilDusk, moonFraction: moonFraction, moonPhase: moonPhase, moonrise: moonrise, moonset: moonset, sunrise: sunrise, sunset: sunset, date: start_date, trip_id: @trip.id)
    
  end

  private 

  def trip_params
    params.require(:trip).permit(:name, :success, :species, :body, :latitude, :longitude, :date, :time, :shared)
  end

  def update_params
    params.require(:trip).permit(:name, :success, :species, :body, :shared)
  end
end
