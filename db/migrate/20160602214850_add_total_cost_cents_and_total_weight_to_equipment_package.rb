class AddTotalCostCentsAndTotalWeightToEquipmentPackage < ActiveRecord::Migration
  def change
    add_column :equipment_packages, :total_cost_cents, :integer
    add_column :equipment_packages, :total_weight, :decimal, precision: 10, scale: 4
  end
end
