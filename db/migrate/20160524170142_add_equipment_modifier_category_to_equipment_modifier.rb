class AddEquipmentModifierCategoryToEquipmentModifier < ActiveRecord::Migration
  def change
    add_reference :equipment_modifiers, :equipment_category, index: true
  end
end
