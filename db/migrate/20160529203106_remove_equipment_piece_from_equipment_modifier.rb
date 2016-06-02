class RemoveEquipmentPieceFromEquipmentModifier < ActiveRecord::Migration
  def change
    remove_foreign_key :equipment_modifiers, :equipment_pieces
    remove_reference :equipment_modifiers, :equipment_piece, index: true
  end
end
