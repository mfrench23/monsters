class AddCostAndWeightFieldsToEquipmentPieces < ActiveRecord::Migration
  def change
    add_column :equipment_pieces, :base_weight, :decimal, :precision => 10, :scale => 4
    add_column :equipment_pieces, :base_cost_cents, :integer
    add_column :equipment_pieces, :weight, :decimal, :precision => 10, :scale => 4
    add_column :equipment_pieces, :cost_cents, :integer
  end
end
