class CreateAstro < ActiveRecord::Migration[5.2]
  def change
    create_table :astros do |t|
      t.text :astronomicalDawn, default: "", null: false
      t.text :astronomicalDusk, default: "", null: false
      t.text :civilDawn, default: "", null: false
      t.text :civilDusk, default: "", null: false
      t.float :moonFraction, default: 0.0, null: false
      t.text :moonPhase, default: "", null: false
      t.text :moonrise, default: "", null: false
      t.text :moonset, default: "", null: false
      t.text :sunset, default: "", null: false
      t.text :sunrise, default: "", null: false
      t.datetime :time, default: "", null: false

      t.belongs_to :trip
    end
  end
end
