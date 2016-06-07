class RemoveEquipmentCategoryIdFromEquipmentModifier < ActiveRecord::Migration
  def change
    remove_column :equipment_modifiers, :equipment_category_id, :integer
  end
end
