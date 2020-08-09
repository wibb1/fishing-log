class AddTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.string :success, null: false
      t.string :species, null: false
      t.text :body
      t.decimal :latitude
      t.decimal :longitude
      t.time :trip_time
      t.belongs_to :user, null: false
      t.boolean :shared, defalut: false

      t.timestamps null: false
    end
  end
end
