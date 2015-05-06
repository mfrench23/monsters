class UniqueCharacteristicMonsters < ActiveRecord::Migration
  def change
    add_index :characteristic_monsters, [:characteristic_id, :monster_id], :unique => true, :name => 'characteristic_monsters_uniq_join_table_idx'
  end
end
