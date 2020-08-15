class AddTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.string :success, null: false
      t.string :species, null: false
      t.text :body, default: ""
      t.decimal :latitude, default: 0.0, null: false
      t.decimal :longitude, default: 0.0, null: false
      t.datetime :trip_time, null: false
      t.string :text_date, default: "", null: false
      t.belongs_to :user, null: false
      t.boolean :shared, defalut: false

      t.timestamps null: false

    end
  end
end
