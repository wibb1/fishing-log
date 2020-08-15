class Weather < ApplicationRecord
  validates :time, presence: true
  validates :text_date, presence: true
  validates :airTemperature, presence: true
  validates :pressure, presence: true
  validates :cloudCover, presence: true
  validates :currentDirection, presence: true
  validates :currentSpeed, presence: true
  validates :gust, presence: true
  validates :humidity, presence: true
  validates :seaLevel, presence: true
  validates :visibility, presence: true
  validates :waveDirection, presence: true
  validates :waveHeight, presence: true
  validates :wavePeriod, presence: true
  validates :windDirection, presence: true
  validates :windSpeed, presence: true

  belongs_to :trip
end
