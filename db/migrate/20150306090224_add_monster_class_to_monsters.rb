class AddMonsterClassToMonsters < ActiveRecord::Migration
  def change
    add_reference :monsters, :monster_class, index: true
    add_foreign_key :monsters, :monster_classes
  end
end
