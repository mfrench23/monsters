class CreateEquipmentModifierSupercategories < ActiveRecord::Migration
  def change
    create_table :equipment_modifier_supercategories do |t|
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
  end
end
