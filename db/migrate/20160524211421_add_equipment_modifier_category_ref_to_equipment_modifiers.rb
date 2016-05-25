class AddEquipmentModifierCategoryRefToEquipmentModifiers < ActiveRecord::Migration
  def change
    add_reference :equipment_modifiers, :equipment_modifier_category, index: true
    add_foreign_key :equipment_modifiers, :equipment_modifier_categories
  end
end
