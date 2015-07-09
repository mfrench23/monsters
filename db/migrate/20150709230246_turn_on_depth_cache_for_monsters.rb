class TurnOnDepthCacheForMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :ancestry_depth, :integer, :default => 0
  end
end
