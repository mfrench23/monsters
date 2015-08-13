class ModifyIndexOnCharacteristicLists < ActiveRecord::Migration
  def change
    add_index :characteristic_lists, [:monster_actable_type, :characteristic_id], unique: true, name: 'index_characteristic_lists_on_monster_type_and_characteristic'
  end
end
