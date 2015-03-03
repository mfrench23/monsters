class CreateDamageResistances < ActiveRecord::Migration
  def change
    create_table :damage_resistances do |t|
      t.references :monster, index: true
      t.references :location, index: true
      t.integer :dr
      t.text :notes

      t.timestamps null: false
    end

  end
end
