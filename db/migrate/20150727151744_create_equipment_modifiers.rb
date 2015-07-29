class CreateEquipmentModifiers < ActiveRecord::Migration
  def change
    create_table :equipment_modifiers do |t|
      t.string :name
      t.string :base_cost_mod
      t.string :base_weight_mod
      t.string :cost_mod
      t.string :weight_mod

      t.timestamps null: false
    end
  end
end
