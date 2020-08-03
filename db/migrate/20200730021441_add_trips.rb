class AddTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.string :success, null: false
      t.string :species, null: false
      t.text :body
      t.decimal :latitude
      t.decimal :longitude
      t.date :trip_date
      t.time :trip_time

      t.timestamps
    end
  end
end
