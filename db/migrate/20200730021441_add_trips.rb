class AddTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.string :success, null: false
      t.string :species, null: false
      t.text :body
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.string :trip_date, null: false
      t.string :trip_time, null: false
      t.belongs_to :user, null: false
      t.boolean :shared, defalut: false

      t.timestamps null: false

    end
  end
end
