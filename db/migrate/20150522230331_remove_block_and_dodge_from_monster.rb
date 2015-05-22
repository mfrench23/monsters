class RemoveBlockAndDodgeFromMonster < ActiveRecord::Migration
  def change
    remove_column :monsters, :block, :integer
    remove_column :monsters, :dodge, :integer
  end
end
