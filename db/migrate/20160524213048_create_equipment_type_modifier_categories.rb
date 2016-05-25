class CreateEquipmentTypeModifierCategories < ActiveRecord::Migration
  def change
    create_table :equipment_type_modifier_categories do |t|
      t.references :equipment_type, index: false
      t.references :equipment_modifier_category, index: false

      t.timestamps null: false
    end
    add_index :equipment_type_modifier_categories, :equipment_type_id, name: 'eq_type_mod_cat_type_idx'
    add_index :equipment_type_modifier_categories, :equipment_modifier_category_id, name: 'eq_type_mod_cat_mod_cat_idx'
    add_foreign_key :equipment_type_modifier_categories, :equipment_types
    add_foreign_key :equipment_type_modifier_categories, :equipment_modifier_categories
  end
end
