class MakeIndexOnMonsterClassesUnique < ActiveRecord::Migration
  def up
    remove_index :monster_classes, :name
    add_index :monster_classes, :name, unique: true
  end
  def down
    remove_index :monster_classes, :name
    add_index :monster_classes, :name
  end
end
