class CreateTide < ActiveRecord::Migration[5.2]
  def change
    create_table :tides do |t|
      t.string :date, null: false
      t.string :first_type, default: "NA"
      t.string :first_time, default: "NA"
      t.string :second_type, default: "NA"
      t.string :second_time, default: "NA"
      t.string :third_type, default: "NA"
      t.string :third_time, default: "NA"
      t.string :fourth_type, default: "NA"
      t.string :fourth_time, default: "NA"

      t.belongs_to :trip
    end
  end
end
