class CreateMovementRates < ActiveRecord::Migration
  def change
    create_table :movement_rates do |t|
      t.references :monster, index: true
      t.references :terrain_type, index: true
      t.integer :rate

      t.timestamps null: false
    end
  end
end
