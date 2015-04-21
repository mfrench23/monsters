class RenameTerrainTypeIdField < ActiveRecord::Migration
  def change
    remove_foreign_key :movement_rates, :terrain_types
    remove_column :movement_rates, :terrain_type_id, :integer
    add_column :movement_rates, :move_type_id, :integer
    add_index "movement_rates", ["move_type_id"], name: "index_movement_rates_on_move_type_id", using: :btree
    add_foreign_key "movement_rates", "move_types", column: "move_type_id"
  end
end
