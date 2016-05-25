class AddIndexToEquipmentModifierCategories < ActiveRecord::Migration
  def change
    add_index :equipment_modifier_categories, :equipment_modifier_category_id, name: 'eq_mod_cat_idx'
  end
end
