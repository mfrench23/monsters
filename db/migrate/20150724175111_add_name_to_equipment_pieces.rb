class AddNameToEquipmentPieces < ActiveRecord::Migration
  def change
    add_column :equipment_pieces, :name, :string
  end
end
