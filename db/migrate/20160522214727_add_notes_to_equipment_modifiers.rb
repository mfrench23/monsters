class AddNotesToEquipmentModifiers < ActiveRecord::Migration
  def change
    add_column :equipment_modifiers, :notes, :text
  end
end
