class CreateEquipmentPieces < ActiveRecord::Migration
  def change
    create_table :equipment_pieces do |t|
      t.references :equipment_type, index: true

      t.timestamps null: false
    end
    add_foreign_key :equipment_pieces, :equipment_types
  end
end
