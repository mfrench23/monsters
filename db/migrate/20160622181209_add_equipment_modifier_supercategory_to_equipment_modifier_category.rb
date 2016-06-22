class AddEquipmentModifierSupercategoryToEquipmentModifierCategory < ActiveRecord::Migration
  def change
    add_reference :equipment_modifier_categories, :equipment_modifier_supercategory
    add_index :equipment_modifier_categories, :equipment_modifier_supercategory_id, :name => 'eq_mod_cat_supercat_idx'
    add_foreign_key :equipment_modifier_categories, :equipment_modifier_supercategories
  end
end
