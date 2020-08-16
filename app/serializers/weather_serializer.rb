class WeatherSerializer < ActiveModel::Serializer
  attributes :id, :date, :time, :airTemperature, :pressure, :cloudCover, :currentDirection, :currentSpeed, :gust, :humidity, :seaLevel, :visibility, :windDirection, :windSpeed

end
