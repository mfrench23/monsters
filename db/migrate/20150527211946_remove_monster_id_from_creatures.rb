class RemoveMonsterIdFromCreatures < ActiveRecord::Migration
  def change
    remove_foreign_key :creatures, :monsters
    remove_column :creatures, :monster_id, :integer
  end
end
