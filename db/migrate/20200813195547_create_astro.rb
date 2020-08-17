class CreateAstro < ActiveRecord::Migration[5.2]
  def change
    create_table :astros do |t|
      t.string :astronomicalDawn, default: "NA"
      t.string :astronomicalDusk, default: "NA"
      t.string :civilDawn, default: "NA"
      t.string :civilDusk, default: "NA"
      t.string :moonFraction, default: "NA"
      t.string :moonPhase, default: "NA"
      t.string :moonrise, default: "NA"
      t.string :moonset, default: "NA"
      t.string :sunset, default: "NA"
      t.string :sunrise, default: "NA"
      t.string :date, default: "NA"

      t.belongs_to :trip
    end
  end
end
