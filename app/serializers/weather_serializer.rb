class WeatherSerializer < ActiveModel::Serializer
  attributes :id, :text_date, :airTemperature, :pressure, :cloudCover, :currentDirection, :currentSpeed, :gust, :humidity, :seaLevel, :visibility, :windDirection, :windSpeed

end
