class CreateWeather < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.string :date, null: false
      t.string :time, null: false
      t.string :airTemperature, default: "NA"
      t.string :pressure, default: "NA"
      t.string :cloudCover, default: "NA"
      t.string :currentDirection, default: "NA"
      t.string :currentSpeed, default: "NA"
      t.string :gust, default: "NA"
      t.string :humidity, default: "NA"
      t.string :seaLevel, default: "NA"
      t.string :visibility, default: "NA"
      t.string :windDirection, default: "NA"
      t.string :windSpeed, default: "NA"

      t.belongs_to :trip

    end
  end
end
