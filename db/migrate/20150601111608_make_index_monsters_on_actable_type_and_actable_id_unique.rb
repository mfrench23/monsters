class MakeIndexMonstersOnActableTypeAndActableIdUnique < ActiveRecord::Migration
  def up
    remove_index :monsters, :name => "index_monsters_on_actable_type_and_actable_id"
    add_index "monsters", ["actable_type", "actable_id"], name: "index_monsters_on_actable_type_and_actable_id", unique: true, using: :btree
  end
  def down
    remove_index :monsters, :name => "index_monsters_on_actable_type_and_actable_id"
    add_index "monsters", ["actable_type", "actable_id"], name: "index_monsters_on_actable_type_and_actable_id", using: :btree
  end
end
