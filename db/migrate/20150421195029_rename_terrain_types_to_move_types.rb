class RenameTerrainTypesToMoveTypes < ActiveRecord::Migration
  def change
    rename_table :terrain_types, :move_types
  end
end
