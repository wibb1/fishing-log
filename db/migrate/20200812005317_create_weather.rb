class CreateWeather < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.datetime :time, null: false
      t.string :text_date, null: false
      t.float :airTemperature, default: 0.0,null: false
      t.float :pressure, default: 0.0,null: false
      t.float :cloudCover, default: 0.0,null: false
      t.float :currentDirection, default: 0.0,null: false
      t.float :currentSpeed, default: 0.0,null: false
      t.float :gust, default: 0.0,null: false
      t.float :humidity, default: 0.0,null: false
      t.float :seaLevel, default: 0.0,null: false
      t.float :visibility, default: 0.0,null: false
      t.float :waveDirection, default: 0.0,null: false
      t.float :waveHeight, default: 0.0,null: false
      t.float :wavePeriod, default: 0.0,null: false
      t.float :windDirection, default: 0.0,null: false
      t.float :windSpeed, default: 0.0,null: false

      t.belongs_to :trip

    end
  end
end
