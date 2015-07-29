class AddEquipmentPieceToEquipmentModifiers < ActiveRecord::Migration
  def change
    add_reference :equipment_modifiers, :equipment_piece, index: true
    add_foreign_key :equipment_modifiers, :equipment_pieces
  end
end
