class AddEquipmentModifierCategoryToRandomEqProfileLineItem < ActiveRecord::Migration
  def change
    add_reference :random_eq_profile_line_items, :equipment_modifier_category
    add_index :random_eq_profile_line_items, :equipment_modifier_category_id, :name => 'rnd_eq_prof_line_itm_cat_idx'
    add_foreign_key :random_eq_profile_line_items, :equipment_modifier_categories
  end
end
