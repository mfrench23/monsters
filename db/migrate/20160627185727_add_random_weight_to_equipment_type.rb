class AddRandomWeightToEquipmentType < ActiveRecord::Migration
  def change
    add_column :equipment_types, :random_weight, :integer
  end
end
