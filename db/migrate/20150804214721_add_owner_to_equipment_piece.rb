class AddOwnerToEquipmentPiece < ActiveRecord::Migration
  def change
    add_reference :equipment_pieces, :owner, polymorphic: true, index: true
  end
end
