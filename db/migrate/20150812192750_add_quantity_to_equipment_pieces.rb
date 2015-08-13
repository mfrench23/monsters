class AddQuantityToEquipmentPieces < ActiveRecord::Migration
  class EquipmentPieces < ActiveRecord::Base
  end

  def change
    add_column :equipment_pieces, :quantity, :integer
    EquipmentPieces.update_all(:quantity => 1)
    change_column_null :equipment_pieces, :quantity, false
  end
end
