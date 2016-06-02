class CreateEquipmentPieceModifiers < ActiveRecord::Migration
  def change
    create_table :equipment_piece_modifiers do |t|
      t.references :equipment_piece, index: true
      t.references :equipment_modifier, index: true
      t.text :notes

      t.timestamps null: false
    end
    add_foreign_key :equipment_piece_modifiers, :equipment_pieces
    add_foreign_key :equipment_piece_modifiers, :equipment_modifiers
  end
end
