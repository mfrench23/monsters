class MakeIndexOnMoveTypesUnique < ActiveRecord::Migration
  def up
    remove_index :move_types, :name
    add_index :move_types, :name, unique: true
  end
  def down
    remove_index :move_types, :name
    add_index :move_types, :name
  end
end
