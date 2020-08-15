class CreateTide < ActiveRecord::Migration[5.2]
  def change
    create_table :tides do |t|
      t.datetime :date, null: false
      t.float :first_type, default: 0.0, null: false
      t.text :first_time, default: ""
      t.float :second_type, default: 0.0, null: false
      t.text :second_time, default: ""
      t.float :third_type, default: 0.0, null: false
      t.text :third_time, default: ""
      t.float :fourth_type, default: 0.0, null: false
      t.text :fourth_time, default: ""

      t.belongs_to :trip
    end
  end
end
