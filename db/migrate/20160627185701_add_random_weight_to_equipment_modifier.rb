class AddRandomWeightToEquipmentModifier < ActiveRecord::Migration
  def change
    add_column :equipment_modifiers, :random_weight, :integer
  end
end
