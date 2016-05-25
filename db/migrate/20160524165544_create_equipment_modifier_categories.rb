class CreateEquipmentModifierCategories < ActiveRecord::Migration
  def change
    create_table :equipment_modifier_categories do |t|
      t.string :name
      t.text :notes

      t.timestamps null: false
    end
  end
end
