class AddIndexToAttacksForMonsterIdAndName < ActiveRecord::Migration
  def up
    add_index :attacks, [:monster_id, :name], unique: true
  end

  def down
    remove_index :attacks, [:monster_id, :name]
  end
end
