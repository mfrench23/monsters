class AddIndexToMonstersActableId < ActiveRecord::Migration
  def change
    add_index :monsters, [:actable_type, :actable_id]
  end
end
